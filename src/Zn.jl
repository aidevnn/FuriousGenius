
struct Zn <: FGroup
    mod::Int
    gHash::UInt
    function Zn(mod::Int)
        if mod < 2
            throw(GroupException(GroupDefinitionEx))
        end
        return new(mod, hash(mod))
    end
end

function GetHash(g::Zn)::UInt
    return g.gHash
end

function GetString(g::Zn)::String
    return "Z$(g.mod)"
end

struct ZnInt <: Elt
    baseGroup::Zn
    k::Int
    eHash::UInt
    function ZnInt(zn::Zn, k::Int)
        k0 = k % zn.mod
        if k0 < 0
            k0 += zn.mod
        end
        return new(zn, k0, hash(k0, zn.gHash))
    end
    function ZnInt(k::Int, mod::Int)
        zn = Zn(mod)
        return ZnInt(zn, k)
    end
end

function GetHash(e::ZnInt)::UInt
    return e.eHash
end

function IsLess(e1::ZnInt, e2::ZnInt)::Bool
    if e1.baseGroup != e2.baseGroup
        throw(GroupException())
    end

    return e1.k < e2.k
end

function GetString(e::ZnInt)::String
    return "$(e.k)"
end

function BaseGroup(e::ZnInt)::Zn
    return e.baseGroup
end

function Neutral(g::Zn)::ZnInt
    return ZnInt(g, 0)
end

function Invert(g::Zn, e::ZnInt)::ZnInt
    if e.baseGroup != g
        throw(GroupException())
    end

    return ZnInt(g, g.mod - e.k)
end

function Op(g::Zn, e1::ZnInt, e2::ZnInt)::ZnInt
    if g != e1.baseGroup || g != e2.baseGroup
        throw(GroupException())
    end
    return ZnInt(g, e1.k + e2.k)
end

function (zn::Zn)(v::Vararg{Int,1})::ZnInt
    ZnInt(zn, v[1])
end
