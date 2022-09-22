using Exceptions

export Elt, FGroup, Neutral, Invert, Op, BaseGroup,
    GetHash, GetString, Times, baseGroupEx, IsLess

# Abstract Types
abstract type FGroup end
abstract type Elt end

# Error Handling
mutable struct baseGroupEx <: Exception
    msg::String
    baseGroupEx() = new("Element doesnt belong to the BaseGroup")
    baseGroupEx(msg0::String) = new(msg0)
end

Base.show(io::IO, bgEx::baseGroupEx) = print(io, bgEx.msg)

# Abstract Functions
# FGroup abstract functions
function GetHash(g::FGroup)::UInt end
function GetString(g::FGroup)::String end

function Neutral(g::FGroup)::Elt end
function Invert(g::FGroup, e::Elt)::Elt end
function Op(g::FGroup, e1::Elt, e2::Elt)::Elt end
function (g::FGroup)(v::Vararg{Int,N})::Elt{FGroup} where {N} end

# Element abstract functions
function GetHash(e::Elt)::UInt end
function GetString(e::Elt)::String end
function BaseGroup(e::Elt)::FGroup end
function IsLess(e1::Elt, e2::Elt)::Bool end

# Taking opportunities from these julia common interfaces
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
        throw(baseGroupEx())
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
