
# Abstract Types
abstract type FGroup end
abstract type CGroup <: FGroup end
abstract type Elt end

# Abstract Functions
# FGroup abstract functions
function GetHash(g::FGroup)::UInt end
function GetString(g::FGroup)::String end

function Neutral(g::FGroup)::Elt end
function Invert(g::FGroup, e::Elt)::Elt end
function Op(g::FGroup, e1::Elt, e2::Elt)::Elt end
function (g::FGroup)(v::Vararg{Any,N})::Elt where {N} end

# Element abstract functions
function GetHash(e::Elt)::UInt end
function GetString(e::Elt)::String end
function BaseGroup(e::Elt)::FGroup end
function IsLess(e1::Elt, e2::Elt)::Bool end

# Taking opportunities from julia common interfaces
Base.hash(g::FGroup, h::UInt)::UInt = hash(GetHash(g), h)
Base.:(==)(g1::FGroup, g2::FGroup)::Bool = GetHash(g1) == GetHash(g2)
Base.show(io::IO, g::FGroup) = print(io, GetString(g))
function Base.hash(e::Elt, h::UInt)::UInt
    hash(GetHash(e), h)
end

function Base.:(==)(e1::Elt, e2::Elt)::Bool
    GetHash(e1) == GetHash(e2)
end

function Base.isless(e1::Elt, e2::Elt)::Bool
    IsLess(e1, e2)
end

function Base.show(io::IO, e::Elt)
    print(io, GetString(e))
end

# Extras
function Times(g::FGroup, e::Elt, p::Int)::Elt
    if g != BaseGroup(e)
        throw(GroupException())
    end

    if p == 0
        return Neutral(g)
    end

    e0 = e
    p0 = p
    if p < 0
        e0 = Invert(g, e)
        p0 = -p
    end
    acc = Neutral(g)
    for i = 1:p0
        acc = Op(g, acc, e0)
    end

    return acc
end

function ContainsElement(g::CGroup, e::Elt)::Bool
    return (e in g.elements)
end

function GetElements(g::CGroup)::Set{Elt}
    g.elements
end

function SetElements(g::CGroup, elements::Set{Elt})
    empty!(g.elements)
    for e in elements
        if BaseGroup(e) != g.baseGroup
            throw(GroupException(BaseGroupEx))
        end
        push!(g.elements, e)
    end
    nothing
end

function GetMonogenics(g::CGroup)::Dict{Elt,Dict{Elt,Int}}
    g.monogenics
end

function SetMonogenics(g::CGroup, monogenics::Dict{Elt,Dict{Elt,Int}})
    empty!(g.monogenics)
    for p in monogenics
        e = p[1]
        if BaseGroup(e) != g.baseGroup
            throw(GroupException(BaseGroupEx))
        end
        gr = Dict{Elt,Int}(p[2])
        push!(g.monogenics, e => gr)
    end
    nothing
end

function GetOrders(g::CGroup)::Dict{Elt,Int}
    g.orders
end

function SetOrders(g::CGroup, orders::Dict{Elt,Int})
    empty!(g.orders)
    for e in orders
        if BaseGroup(e[1]) != g.baseGroup
            throw(GroupException(BaseGroupEx))
        end
        push!(g.orders, e)
    end
    nothing
end

function GetGroupType(g::CGroup)::GroupType
    g.groupType
end

function SetGroupType(g::CGroup, groupType::GroupType)
    g.groupType = groupType
    nothing
end
