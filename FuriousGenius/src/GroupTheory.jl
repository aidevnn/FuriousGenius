using Exceptions

export Elt, FGroup, Neutral, Invert, Op, BaseGroup,
    GetHash, GetString, Pow, baseGroupEx

# Abstract Types
abstract type Elt end
abstract type FGroup end

# Error Handling
mutable struct baseGroupEx <: Exception
end

# Abstract Functions
function Neutral(g::FGroup)::Elt end
function Invert(g::FGroup, e::Elt)::Elt end
function Op(g::FGroup, e1::Elt, e2::Elt)::Elt end
function BaseGroup(e::Elt)::FGroup end
function GetHash(e::Elt)::UInt end
function GetHash(g::FGroup)::UInt end
function GetString(e::Elt)::String end
function GetString(g::FGroup)::String end

# Explicit Functions
function Pow(g::FGroup, e::Elt, p::Int)::Elt
    if g != BaseGroup(e)
        throw(baseGroupEx())
    end

    if p == 0
        return Neutral(g)
    end

    e0 = e
    p0 = p
    if p < 0
        x0 = Invert(g, e)
        p0 = -p
    end
    acc = Neutral(g)
    for i = 0:p
        acc = Op(g, acc, e0)
    end

    return acc
end

Base.:(==)(g1::FGroup, g2::FGroup)::Bool = GetHash(g1) == GetHash(g2)
Base.:(==)(e1::Elt, e2::Elt)::Bool = GetHash(e1) == GetHash(e2)

Base.:(*)(e1::Elt, e2::Elt)::Elt = Op(BaseGroup(e1), e1, e2)

Base.show(io::IO, g::FGroup) = print(io, GetString(g))
Base.show(io::IO, e::Elt) = print(io, GetString(e))
Base.show(io::IO, e::baseGroupEx) = print(io, "Element doesnt belong to the BaseGroup")
