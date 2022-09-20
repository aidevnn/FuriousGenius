
export ZnInt, Zn, Neutral, Invert, Op, BaseGroup, GetHash, GetString

struct Zn <: FGroup
    mod::Int
    gHash::UInt
    function Zn(mod::Int)
        if mod < 2
            error("mod in Zn(mod) must be at least 2")
        end
        hash0 = hash(mod)
        return new(mod, hash0)
    end
end

struct ZnInt <: Elt
    baseGroup::Zn
    k::Int
    eltHash::UInt
    function ZnInt(zn::Zn, k::Int)
        k0 = k % zn.mod
        if k0 < 0
            k0 += zn.mod
        end
        hash0 = hash(k0, hash(zn.mod))
        return new(zn, k0, hash0)
    end
    function ZnInt(k::Int, mod::Int)
        zn = Zn(mod)
        return ZnInt(zn, k)
    end
end

function Neutral(g::Zn)::ZnInt
    return ZnInt(g, 0)
end

function Invert(g::Zn, e::ZnInt)::ZnInt
    if e.baseGroup != g
        throw(baseGroupEx())
    end

    return ZnInt(g, g.mod - e.k)
end

function Op(g::Zn, e1::ZnInt, e2::ZnInt)::ZnInt
    if g != e1.baseGroup || g != e2.baseGroup
        throw(baseGroupEx())
    end
    return ZnInt(g, e1.k + e2.k)
end

function BaseGroup(e::ZnInt)::Zn
    return e.baseGroup
end

function GetHash(e::ZnInt)::UInt
    return e.eltHash
end

function GetHash(g::Zn)::UInt
    return g.gHash
end

function GetString(e::ZnInt)::String
    return "$(e.k)"
end

function GetString(g::Zn)::String
    return "Z$(g.mod)"
end
