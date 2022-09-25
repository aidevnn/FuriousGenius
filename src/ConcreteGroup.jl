
function Generate(g::FGroup, leftOp::Set{Elt}, rightOp::Set{Elt})::Set{Elt}
    if length(leftOp) == 0 || length(rightOp) == 0
        return Set{Elt}()
    end

    n = Neutral(g)
    set = Set{Elt}(leftOp)
    q = Vector{Elt}(collect(leftOp))
    if (!(n in q))
        push!(q, n)
        push!(set, n)
    end

    while length(q) != 0
        e0 = pop!(q)
        for e1 in rightOp
            e2 = Op(g, e0, e1)
            if !(e2 in set)
                push!(set, e2)
                pushfirst!(q, e2)
            end
        end
    end

    return set
end

Generate(g::FGroup, gens::Set{Elt})::Set{Elt} = Generate(g, Set{Elt}([Neutral(g)]), gens)

function Monogenic(g::FGroup, e::Elt)::Dict{Elt,Int}
    map = Dict{Elt,Int}()
    n = Neutral(g)
    e0 = e
    p = 1
    map[e0] = p

    while e0 != n
        e0 = Op(g, e0, e)
        p += 1
        map[e0] = p
    end
    return map
end

function Generators(g::FGroup, elements::Set{Elt})::Dict{Elt,Dict{Elt,Int}}
    n = Neutral(g)
    list = Vector{Elt}(collect(elements))
    sort!(list)
    gens = Dict{Elt,Dict{Elt,Int}}()

    while length(list) != 0
        e = first(list)
        s = Monogenic(g, e)
        setdiff!(list, keys(s))
        if length(gens) == 0
            gens[e] = s
            continue
        end

        gens0 = Dict{Elt,Dict{Elt,Int}}(gens)
        empty!(gens)
        done = false
        for p in gens0
            e0 = p.first
            s0 = p.second
            if length(s) <= length(s0)
                gens[e0] = s0
                if !done && haskey(s0, e)
                    done = true
                end
            else
                if haskey(s, e0)
                    if !haskey(gens, e)
                        gens[e] = s
                        done = true
                    end
                else
                    gens[e0] = s0
                end
            end
        end

        if !done
            gens[e] = s
        end
    end

    return gens
end

function ElementOrder(gens::Dict{Elt,Dict{Elt,Int}})::Dict{Elt,Int}
    orders = Dict{Elt,Int}()
    for p0 in gens
        s = p0.second
        n = length(s)
        for p1 in s
            e = p1.first
            p = p1.second
            o = n / gcd(n, p)
            if !haskey(orders, e)
                orders[e] = o
            elseif orders[e] != o
                throw(GroupException("TODO e=$(e) p=$(orders[e]) ? $o")) # TODO
            end
        end
    end
    return orders
end

function IsAbelian(g::FGroup, elements::Vector{Elt})::Bool
    for e0 in elements
        for e1 in elements
            e01 = Op(g, e0, e1)
            e10 = Op(g, e1, e0)
            if e01 != e10
                return false
            end
        end
    end

    return true
end

mutable struct ConcreteGroup <: CGroup
    baseGroup::FGroup
    superGroup::Union{CGroup,Nothing}
    elements::Vector{Elt}
    groupType::GroupType
    monogenics::Dict{Elt,Dict{Elt,Int}}
    orders::Dict{Elt,Int}
    cgHash::UInt
    function ConcreteGroup(bg::FGroup)
        bg0 = bg isa CGroup ? bg.baseGroup : bg
        cg0 = bg isa CGroup ? bg : nothing
        n = Neutral(bg0)
        elts = Vector{Elt}([n])
        orders = Dict{Elt,Int}(n => 1)
        mg = Dict{Elt,Dict{Elt,Int}}(n => Dict{Elt,Int}(n => 1))
        return new(bg0, cg0, elts, AbelianGroup, mg, orders, hash(uuid1()))
    end
end

function GetHash(g::ConcreteGroup)::UInt
    g.cgHash
end

function GetString(g::ConcreteGroup)::String
    return "NoName" # TODO
end

function Neutral(g::ConcreteGroup)::Elt
    if isnothing(g.superGroup)
        return Neutral(g.baseGroup)
    else
        return Neutral(g.superGroup)
    end
end

function Invert(g::ConcreteGroup, e::Elt)::Elt
    if isnothing(g.superGroup)
        return Invert(g.baseGroup, e)
    else
        return Invert(g.superGroup, e)
    end
end

function Op(g::ConcreteGroup, e1::Elt, e2::Elt)::Elt
    if isnothing(g.superGroup)
        return Op(g.baseGroup, e1, e2)
    else
        return Op(g.superGroup, e1, e2)
    end
end

function (g::ConcreteGroup)(v::Vararg{Int,1})::Elt
    g.elements[v[1]]
end

function CreateGroupByGenerators(g::FGroup, vs::Vararg{Elt})::CGroup
    vs0 = Set{Elt}([vs...])
    if g isa CGroup
        if any(e -> !(e in g.elements), vs0)
            throw(GroupException(SuperGroupEx))
        end
    end

    elements = Generate(g, vs0)
    monogenics = Generators(g, elements)
    grouptype = IsAbelian(g, collect(keys(monogenics))) ? AbelianGroup : NonAbelianGroup
    orders = ElementOrder(monogenics)

    gr = ConcreteGroup(g)
    SetElements(gr, Vector{Elt}([elements...]))
    SetMonogenics(gr, monogenics)
    SetOrders(gr, orders)
    SetGroupType(gr, grouptype)

    return gr
end
