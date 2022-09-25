
function Cosets(g::ConcreteGroup, h::ConcreteGroup)::Set{Set{Elt}}
    if !(issubset(h.elements, g.elements))
        throw(GroupException(NotSubGroupEx))
    end

    cosets = Set{Set{Elt}}()
    for x in g.elements
        xi = Invert(g, x)
        xH = Set{Elt}([Op(g, x, he) for he in h.elements])
        xHxi = Set([Op(g, xh, xi) for xh in xH])
        if !issetequal(h.elements, xHxi)
            throw(GroupException(NotNormalEx))
        end

        if all(s -> !issetequal(s, xH), cosets)
            push!(cosets, xH)
        end
    end

    return cosets
end

function DisplayCosets(cosets::Set{Set{Elt}})
    println("Cosets")
    sets = sort([cosets...], by=minimum)
    n = length(sets)
    for i = 1:n
        s = sets[i]
        e = minimum(s)
        v = sort([s...])
        println("($i) = $e")
        for ei in v
            println("   $ei")
        end
    end
    println()
end

function Representants(cosets::Set{Set{Elt}})::Dict{Elt,Elt}
    repr = Dict{Elt,Elt}()
    for s in cosets
        r = minimum(s)
        for e in s
            push!(repr, e => r)
        end
    end
    return repr
end

mutable struct QuotientGroup <: CGroup
    baseGroup::FGroup
    superGroup::CGroup
    normSubGroup::CGroup
    cosets::Set{Set{Elt}}
    representants::Dict{Elt,Elt}
    elements::Vector{Elt}
    groupType::GroupType
    monogenics::Dict{Elt,Dict{Elt,Int}}
    orders::Dict{Elt,Int}
    cgHash::UInt
    function QuotientGroup(G::CGroup, H::CGroup)
        if G.baseGroup != H.baseGroup
            throw(GroupException(BaseGroupEx))
        end

        bgr = G.baseGroup
        sgr = G
        ngr = H
        cst = Cosets(G, H)
        rep = Representants(cst)
        n = Neutral(bgr)
        elts = Vector{Elt}([n])
        mg = Dict{Elt,Dict{Elt,Int}}(n => Dict{Elt,Int}(n => 1))
        orders = Dict{Elt,Int}(n => 1)
        return new(bgr, sgr, ngr, cst, rep, elts, NonAbelianGroup, mg, orders, hash(uuid1()))
    end
end

function GetHash(g::QuotientGroup)::UInt
    g.cgHash
end

function GetString(g::QuotientGroup)::String
    return "NoName" # TODO
end

function Neutral(g::QuotientGroup)::Elt
    Neutral(g.superGroup)
end

function Invert(g::QuotientGroup, e::Elt)::Elt
    e0 = Invert(g.superGroup, e)
    return g.representants[e0]
end

function Op(g::QuotientGroup, e1::Elt, e2::Elt)::Elt
    e0 = Op(g.superGroup, e1, e2)
    return g.representants[e0]
end

function (g::QuotientGroup)(v::Vararg{Int,1})::Elt
    g.elements[v[1]]
end

function CreateQuotientGroup(G::CGroup, H::CGroup)::CGroup
    quo = QuotientGroup(G, H)

    elements = Set{Elt}(values(quo.representants))
    monogenics = Generators(quo, elements)
    grouptype = IsAbelian(quo, collect(keys(monogenics))) ? AbelianGroup : NonAbelianGroup
    orders = ElementOrder(monogenics)

    SetElements(quo, Vector{Elt}([elements...]))
    SetMonogenics(quo, monogenics)
    SetOrders(quo, orders)
    SetGroupType(quo, grouptype)

    return quo
end

function DisplayCosets(quo::QuotientGroup)
    DisplayCosets(quo.cosets)
end
