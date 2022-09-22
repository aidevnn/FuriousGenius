
export G2p, E2p, BaseGroup, IsLess, GetHash, GetString, Neutral, Invert, Op

struct G2p{T1<:UserGroup,T2<:UserGroup} <: FGroup
    g1::T1
    g2::T2
    gpHash::UInt
    function G2p{T1,T2}(g1::T1, g2::T2) where {T1<:UserGroup,T2<:UserGroup}
        hsh = hash(GetHash(g1), GetHash(g2))
        new(g1, g2, hsh)
    end
end

function GetHash(gp::G2p{T1,T2})::UInt where {T1<:UserGroup,T2<:UserGroup}
    gp.gpHash
end

function GetString(gp::G2p{T1,T2})::String where {T1<:UserGroup,T2<:UserGroup}
    "$(GetString(gp.g1)) x $(GetString(gp.g2))"
end

struct E2p{T1<:UserGroup,T2<:UserGroup} <: Elt{G2p{T1,T2}}
    baseGroup::G2p{T1,T2}
    e1::Elt{T1}
    e2::Elt{T2}
    epHash::UInt
    function E2p{T1,T2}(e1::Elt{T1}, e2::Elt{T2}) where {T1<:UserGroup,T2<:UserGroup}
        gp = G2p{T1,T2}(BaseGroup(e1), BaseGroup(e2))
        new(gp, e1, e2, hash(GetHash(e1), GetHash(e2)))
    end
    function E2p{T1,T2}(gp::G2p{T1,T2}, e1::Elt{T1}, e2::Elt{T2}) where {T1<:UserGroup,T2<:UserGroup}
        hsh = hash(GetHash(e1), GetHash(e2))
        new(gp, e1, e2, hsh)
    end
end

function BaseGroup(ep::E2p{T1,T2})::G2p{T1,T2} where {T1<:UserGroup,T2<:UserGroup}
    ep.baseGroup
end

function IsLess(ep1::E2p{T1,T2}, ep2::E2p{T1,T2})::Bool where {T1<:UserGroup,T2<:UserGroup}
    if ep1.e1 != ep2.e1
        return IsLess(ep1.e, ep2.e1)
    end

    return IsLess(ep1.e2, ep2.e2)
end

function GetHash(ep::E2p{T1,T2})::UInt where {T1<:UserGroup,T2<:UserGroup}
    ep.epHash
end

function GetString(ep::E2p{T1,T2})::String where {T1<:UserGroup,T2<:UserGroup}
    "($(GetString(ep.e1)), $(GetString(ep.e2)))"
end

function Neutral(gp::G2p{T1,T2})::Elt{G2p{T1,T2}} where {T1<:UserGroup,T2<:UserGroup}
    E2p{T1,T2}(Neutral(gp.g1), Neutral(gp.g2))
end

function Invert(gp::G2p{T1,T2}, ep::E2p{T1,T2})::Elt{G2p{T1,T2}} where {T1<:UserGroup,T2<:UserGroup}
    E2p{T1,T2}(Invert(gp.g1, ep.e1), Invert(gp.g2, ep.e2))
end

function Op(gp::G2p{T1,T2}, ep1::E2p{T1,T2}, ep2::E2p{T1,T2})::Elt{G2p{T1,T2}} where {T1<:UserGroup,T2<:UserGroup}
    E2p{T1,T2}(Op(gp.g1, ep1.e1, ep2.e1), Op(gp.g2, ep1.e2, ep2.e2))
end

function (g::G2p{T1,T2})(k1::Int, k2::Int)::Elt{G2p{T1,T2}} where {T1<:UserGroup,T2<:UserGroup}
    E2p{T1,T2}(g, g.g1(k1), g.g2(k2))
end

