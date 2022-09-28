using FuriousGenius

#############################################
#                                           #
#             Quartenions Q8                #
#         bruteforce in Symmetric 8         #
#                                           #
#############################################

# All Permutations
allPerms8 = AllPerms(8)
# Symmetric 8
s8 = Sn(8)

id8 = [1:8...]

function PermOrder(p::Vector{Int})::Int
    p0 = Vector(id8)
    for k = 1:16
        p0 = p0[p]
        if p0 == id8
            return k
        end
    end
end

t0 = time()
# All 4-cycles or composition of disjunct 4-cycles
all4cyclesTable = Vector{Vector{Int}}()
for t in allPerms8
    m = PermOrder(t)
    if m == 4
        push!(all4cyclesTable, t)
    end
end


# a^4 = 1 and a^2 = b^2 and a^-1 = b.a.b^-1
# first solution
solve1() =
    for a in all4cyclesTable
        a2 = a[a]
        ai = invperm(a)
        for b in all4cyclesTable
            if a != b
                b2 = b[b]
                if a2 == b2
                    babi = b[a][invperm(b)]
                    if ai == babi
                        return (a, b)
                    end
                end
            end
        end
    end

(a, b) = solve1()
timeMs = round(1000 * (time() - t0))
@show length(all4cyclesTable)
@show Perm(s8, a) Perm(s8, b)
@show timeMs

t0 = time()
# All 4-cycles or composition of disjunct 4-cycles
all4cycles = Vector{Perm}()
for t in allPerms8
    p = Perm(s8, t)
    m = Monogenic(s8, p)
    if length(m) == 4
        push!(all4cycles, p)
    end
end

# a^4 = 1 and a^2 = b^2 and a^-1 = b.a.b^-1
# first solution
solve2() =
    for a in all4cycles
        a2 = Op(s8, a, a)
        ai = Invert(s8, a)
        for b in all4cycles
            if a != b && a2 == Op(s8, b, b) && ai == Op(s8, Op(s8, b, a), Invert(s8, b))
                return (a, b)
            end
        end
    end

(a, b) = solve2()
timeMs = round(1000 * (time() - t0))

println()
@show length(all4cycles)
println("Q8 generators")
@show a b
@show timeMs

Q8 = CreateGroupByGenerators(s8, a, b)
DisplayDetails(Q8)
