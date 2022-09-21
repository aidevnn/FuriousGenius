using Exceptions

export Elt, FGroup, UserGroup, Neutral, Invert, Op, BaseGroup,
    GetHash, GetString, Times, baseGroupEx, IsLess, allsame

# Abstract Types
abstract type FGroup end
abstract type UserGroup <: FGroup end
abstract type Elt{T<:FGroup} end

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
function Neutral(g::T)::Elt{T} where {T<:FGroup} end
function Invert(g::T, e::Elt{T})::Elt{T} where {T<:FGroup} end
function Op(g::T, e1::Elt{T}, e2::Elt{T})::Elt{T} where {T<:FGroup} end

# Element abstract functions
function BaseGroup(e::Elt{T})::T where {T<:FGroup} end
function IsLess(e1::Elt{T}, e2::Elt{T})::Bool where {T<:FGroup} end
function GetHash(e::Elt{T})::UInt where {T<:FGroup} end
function GetString(e::Elt{T})::String where {T<:FGroup} end

# Taking opportunities from these julia common interfaces
Base.hash(g::FGroup)::UInt = GetHash(g)
Base.:(==)(g1::FGroup, g2::FGroup)::Bool = GetHash(g1) == GetHash(g2)
Base.show(io::IO, g::FGroup) = print(io, GetString(g))
function Base.hash(e::Elt{T}, h::UInt)::UInt where {T<:FGroup}
    hash(GetHash(e), h)
end

function Base.:(==)(e1::Elt{T}, e2::Elt{T})::Bool where {T<:FGroup}
    GetHash(e1) == GetHash(e2)
end

function Base.isless(e1::Elt{T}, e2::Elt{T})::Bool where {T<:FGroup}
    IsLess(e1, e2)
end

function Base.show(io::IO, e::Elt{T}) where {T<:FGroup}
    print(io, GetString(e))
end

# Extras
function Times(g::T, e::Elt{T}, p::Int)::Elt{T} where {T<:FGroup}
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
