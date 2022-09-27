
mutable struct NxG <: CGroup
    N::CGroup
    G::CGroup
    actions::Dict{Elt,Function}
    actionsStr::Dict{Elt,String}
    baseGroup::FGroup
    superGroup::Union{CGroup,Nothing}
    elements::Set{Elt}
    groupType::GroupType
    monogenics::Dict{Elt,Dict{Elt,Int}}
    orders::Dict{Elt,Int}
    gpHash::UInt
    function NxG(N::CGroup, G::CGroup)
        actions = Dict{Elt,Function}()
        actionsStr = Dict{Elt,String}()
        bg = Gp{2}(N.baseGroup, G.baseGroup)
        elts = Set{Elt}()
        mg = Dict{Elt,Dict{Elt,Int}}()
        orders = Dict{Elt,Int}()
        hsh = hash(GetHash(N), GetHash(G))
        return new(N, G, actions, actionsStr, bg, nothing, elts, AbelianGroup, mg, orders, hsh)
    end
end

function GetHash(g::NxG)::UInt
    g.gpHash
end

function GetString(g::NxG)::String
    return "($(g.N) ⋊ $(g.G))"
end

struct Eng <: Elt
    baseGroup::FGroup
    n::Elt
    g::Elt
    epHash::UInt
    function Eng(ng::NxG, n::Elt, g::Elt)
        if !ContainsElement(ng.N, n) || !ContainsElement(ng.G, g)
            throw(GroupException(BaseGroupEx))
        end
        hsh = hash(GetHash(n), GetHash(g))
        return new(ng.baseGroup, n, g, hsh)
    end
end

function GetHash(e::Eng)::UInt
    e.epHash
end

function GetString(e::Eng)::String
    "($(e.n), $(e.g))"
end

function BaseGroup(e::Eng)::FGroup
    e.baseGroup
end

function IsLess(e1::Eng, e2::Eng)::Bool
    if e1.n == e2.n
        return IsLess(e1.g, e2.g)
    end

    return IsLess(e1.n, e2.n)
end

function Neutral(ng::NxG)::Eng
    Eng(ng, Neutral(ng.N), Neutral(ng.G))
end

function Invert(ng::NxG, e::Eng)
    gi = Invert(ng.G, e.g)
    return Eng(ng, ng.actions[gi](Invert(ng.N, e.n)), gi)
end

function Op(ng::NxG, e1::Eng, e2::Eng)::Eng
    Eng(ng, Op(ng.N, e1.n, ng.actions[e1.g](e2.n)), Op(ng.G, e1.g, e2.g))
end

function (ng::NxG)(v::Vararg{Elt,2})::Eng
    Eng(ng, v[1], v[2])
end

function PowMod(i::Int, p::Int, n::Int)::Int
    i0 = 1
    for k = 1:p
        i0 = mod(i * i0, n)
    end
    return i0
end
function Solve(cn::Int, cg::Int)::Int
    for i = 2:cn-1
        if gcd(i, cn) == 1 && PowMod(i, cg, cn) == 1
            return i
        end
    end
    return 0
end

function CreateSemiDirectProduct(N::CGroup, G::CGroup)::CGroup
    if length(N.monogenics) != 1 || length(G.monogenics) != 1
        throw(GroupException(CyclicsGroupEx))
    end

    cn = length(N.elements)
    cg = length(G.elements)
    pow = Solve(cn, cg)
    if pow == 0
        throw(GroupException(SemiDirectProdEx))
    end

    actions = Dict{Elt,Function}()
    actionsStr = Dict{Elt,String}()
    g0 = collect(keys(G.monogenics))[1]
    actions[Neutral(G)] = function (x)
        return x
    end
    actionsStr[Neutral(G)] = "x->x"
    for k = 2:cg
        k0 = PowMod(pow, k - 1, cn)
        let k1 = k0
            g1 = Times(G, g0, k - 1)
            actions[g1] = function (x)
                return Times(N, x, k1)
            end
            actionsStr[g1] = k1 == 1 ? "x->x" : "x->x^$k1"
        end
    end

    nxg = NxG(N, G)
    nxg.superGroup = ConcreteGroup(nxg)
    nxg.actions = actions
    nxg.actionsStr = actionsStr
    elements = Set{Elt}()
    for n0 in N.elements
        for g0 in G.elements
            push!(elements, Eng(nxg, n0, g0))
        end
    end

    monogenics = Generators(nxg, elements)
    grouptype = IsAbelian(nxg, collect(keys(monogenics))) ? AbelianGroup : NonAbelianGroup
    orders = ElementOrder(monogenics)
    SetElements(nxg, elements)
    SetMonogenics(nxg, monogenics)
    SetOrders(nxg, orders)
    SetGroupType(nxg, grouptype)

    return nxg
end

function DisplayActions(nxg::NxG)
    println("Actions")
    cg = length(nxg.G.elements)
    g1 = collect(keys(nxg.G.monogenics))[1]
    g0 = Neutral(nxg.G)
    for i = 1:cg
        a = nxg.actionsStr[g0]
        println("g($g0) : $a")
        g0 = Op(nxg.G, g0, g1)
    end
    println()
    nothing
end