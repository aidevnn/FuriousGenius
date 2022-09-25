
function CyclesToPermutation(N::Int, cycles::Vector{Vector{Int}})::Vector{Int}
    if N < 2
        return [1]
    end

    p = [1:N...]
    for cycle in cycles
        if all(i -> (1 <= i <= N), cycle) && length(cycle) == length(Set(cycle))
            n = length(cycle)
            c1 = p[cycle[1]]
            for i = 1:n-1
                p[cycle[i]] = p[cycle[i+1]]
            end
            p[cycle[n]] = c1
        end
    end

    return p
end

function PermutationToCycles(N::Int, p::Vector{Int})::Vector{Vector{Int}}
    cycles = Vector{Vector{Int}}()
    if all(i -> (1 <= i <= N), p) && length(p) == N && length(p) == length(Set(p))
        dic = Dict([i => p[i] for i = 1:N])
        while length(dic) != 0
            v = minimum(dic)
            if v[1] == v[2]
                delete!(dic, v[1])
                continue
            end

            idx = v[1]
            cycle = [idx]
            while true
                idx0 = dic[idx]
                if idx0 == v[1]
                    delete!(dic, idx)
                    break
                end
                push!(cycle, idx0)
                delete!(dic, idx)
                idx = idx0
            end

            push!(cycles, cycle)
        end
    end
    return cycles
end

allPermsDict = Dict{Int,Vector{Vector{Int}}}(1 => [[1]])
function AllPerms(N::Int)
    if haskey(allPermsDict, N)
        return allPermsDict[N]
    end
    arr = AllPerms(N - 1)
    set = Vector{Int}[]
    pc = CyclesToPermutation(N, [[1:N...]])
    for p in arr
        p0 = [p...]
        push!(p0, N)
        p1 = [p0...]
        for i = 1:N
            permute!(p1, pc)
            push!(set, [p1...])
        end
    end
    set0 = sort(set)
    allPermsDict[N] = set0
    return set0
end
