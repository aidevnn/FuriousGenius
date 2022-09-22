
export Gp, Ep, BaseGroup, IsLess, GetHash, GetString, Neutral, Invert, Op

struct Gp{N} <: FGroup
    c::NTuple{N,FGroup}
    gpHash::UInt
    function Gp{N}(v::Vararg{FGroup,N}) where {N}
        c0 = NTuple{N,FGroup}(v)
        hsh = hash(c0)
        return new(c0, hsh)
    end
    function Gp{N}(v::NTuple{N,FGroup}) where {N}
        hsh = hash(v)
        return new(v, hsh)
    end
end

function GetHash(g::Gp{N})::UInt where {N}
    g.gpHash
end

function GetString(g::Gp{N})::String where {N}
    string(g.c)
end

struct Ep{N} <: Elt
    baseGroup::Gp{N}
    c::NTuple{N,Elt}
    epHash::UInt
    function Ep{N}(v::Vararg{Elt,N}) where {N}
        bg = Gp{N}(map(BaseGroup, v))
        c0 = NTuple{N,Elt}(v)
        hsh = hash(c0)
        return new(bg, c0, hsh)
    end
    function Ep{N}(v::NTuple{N,Elt}) where {N}
        bg = Gp{N}(map(BaseGroup, v))
        hsh = hash(v)
        return new(bg, v, hsh)
    end
end

function GetHash(e::Ep{N})::UInt where {N}
    e.epHash
end

function GetString(e::Ep{N})::String where {N}
    string(e.c)
end

function BaseGroup(e::Ep{N})::Gp{N} where {N}
    e.baseGroup
end

function IsLess(e1::Ep{N}, e2::Ep{N})::Bool where {N}
    all(IsLess.(e1.c, e2.c))
end

function Neutral(g::Gp{N})::Ep{N} where {N}
    Ep{N}(Neutral.(g.c))
end

function Invert(g::Gp{N}, e::Ep{N})::Ep{N} where {N}
    Ep{N}(Invert.(g.c, e.c))
end

function Op(g::Gp{N}, e1::Ep{N}, e2::Ep{N})::Ep{N} where {N}
    Ep{N}(Op.(g.c, e1.c, e2.c))
end

function (g::Gp{N})(v::Vararg{Int,N})::Ep{N} where {N}
    Ep{N}(map.(g.c, v))
end
