
function CyclesToPermutation(N::Int, cycles::Vector{Vector{Int}})::Vector{Int}
    if N < 2
        return [1]
    end

    p = [1:N...]
    for cycle in cycles
        p0 = [1:N...]
        if all(i -> (1 <= i <= N), cycle) && length(cycle) == length(Set(cycle))
            n = length(cycle)
            c1 = cycle[1]
            for i = 1:n-1
                p0[cycle[i]] = p0[cycle[i+1]]
            end
            p0[cycle[n]] = c1
        end
        permute!(p, p0)
    end

    return p
end

function PermutationToCycles(N::Int, p::Vector{Int})::Vector{Vector{Int}}
    cycles = Vector{Vector{Int}}()
    if all(i -> (1 <= i <= N), p) && length(p) == N && length(p) == length(Set(p))
        for k = 1:N
            idx = k
            sz = 0
            cycle = [idx]
            while sz != length(cycle)
                sz = length(cycle)
                idx = p[idx]
                if !(idx in cycle)
                    push!(cycle, idx)
                end
            end

            if sz != 1
                if all(c -> !issetequal(c, cycle), cycles)
                    push!(cycles, cycle)
                end
            end
        end
    end
    return cycles
end
