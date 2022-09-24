
permForm = PermutationForm(2)

function ShowTable()
    global permForm = PermutationForm(1)
    return permForm
end

function ShowCycles()
    global permForm = PermutationForm(1)
    return permForm
end

struct Sn <: FGroup
    N::Int
    gHash::UInt
    function Sn(N::Int)
        if N < 2
            throw(GroupException(GroupDefinitionEx))
        end
        return new(N, hash(N))
    end
end

function GetHash(g::Sn)::UInt
    return g.gHash
end

function GetString(g::Sn)::String
    return "S$(g.N)"
end

struct Perm <: Elt
    baseGroup::Sn
    p::Vector{Int}
    eHash::UInt
    function Perm(sn::Sn, p::Vector{Int})
        new(sn, p, hash(p, sn.gHash))
    end
    function Perm(sn::Sn, cycles::Vector{Vector{Int}})
        p = CyclesToPermutation(sn.N, cycles)
        return Perm(sn, p)
    end
end

function GetHash(e::Perm)::UInt
    return e.eHash
end

function IsLess(e1::Perm, e2::Perm)::Bool
    if e1.baseGroup != e2.baseGroup
        throw(GroupException())
    end

    return e1.p < e2.p
end

function GetString(e::Perm)::String
    if permForm == PermutationForm(1)
        return "$(e.p)"
    end

    cycles = PermutationToCycles(e.baseGroup.N, e.p)
    if length(cycles) == 0
        return "[]"
    end

    return "$(cycles)"
end

function BaseGroup(e::Perm)::Sn
    return e.baseGroup
end

function Neutral(g::Sn)::Perm
    return Perm(g, [1:g.N...])
end

function Invert(g::Sn, e::Perm)::Perm
    if e.baseGroup != g
        throw(GroupException())
    end

    return Perm(g, invperm(e.p))
end

function Op(g::Sn, e1::Perm, e2::Perm)::Perm
    if g != e1.baseGroup || g != e2.baseGroup
        throw(GroupException())
    end
    p = [e1.p...]
    permute!(p, e2.p)
    return Perm(g, p)
end

function (sn::Sn)(v::Vararg{Vector{Int}})::Perm
    p = CyclesToPermutation(sn.N, [v...])
    return Perm(sn, p)
end

