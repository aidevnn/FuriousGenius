using BenchmarkTools
using FuriousGenius
using FuriousGenius: ByValue, ByOrder

ShowTable()

z2 = Zn(2)
z3 = Zn(3)
z4 = Zn(4)
s3 = Sn(3)
s4 = Sn(4)

# S4 = CreateGroupByGenerators(s4, s4([1, 2]), s4([1:4...]))

# K4 = CreateGroupByGenerators(s4, s4([1, 3], [2, 4]), s4([1, 2], [3, 4]))
# DisplayDetails(K4, "K4")

# S3 = CreateGroupByGenerators(s3, s3([1, 2]), s3([1, 2, 3]))
# DisplayDetails(S3, "S3")

# zx = Gp{3}(z2, z2, z3)
# gx = CreateGroupByGenerators(zx, zx(1, 0, 0), zx(0, 1, 0), zx(0, 0, 1))
# DisplayDetails(gx)

# zx = Gp{2}(z3, z4)
# gx = CreateGroupByGenerators(zx, zx(1, 0), zx(0, 1))
# DisplayDetails(gx)

# S4 = CreateGroupByGenerators(s4, s4([1, 2]), s4([1:4...]))
# A4 = CreateGroupByGenerators(S4, s4([1, 3], [2, 4]), s4([1, 2, 3]))
# DisplayDetails(A4, "A4")

# z20 = Zn(20)
# Z20 = CreateGroupByGenerators(z20, z20(1))
# Z4 = CreateGroupByGenerators(Z20, z20(5))

# s4 = Sn(4)
# K4 = CreateGroupByGenerators(s4, s4([1, 3], [2, 4]), s4([1, 2], [3, 4]))
# A4 = CreateGroupByGenerators(s4, s4([1, 3], [2, 4]), s4([1, 2, 3]))

# DisplayCosets(Cosets(Z20, Z4))
# DisplayCosets(Cosets(A4, K4))
# @show Representants(Cosets(Z20, Z4))

# z40 = Zn(40)
# Z20 = CreateGroupByGenerators(z40, z40(2))
# Z4 = CreateGroupByGenerators(z40, z40(10))
# Z5 = CreateGroupByGenerators(z40, z40(8))

# repr = Representants(Cosets(Z20, Z5))
# for e in sort([repr...], by=x -> (x[2], x[1]))
#     println(e[1], " => ", e[2])
# end

# zx = Gp{2}(z3, z4)
# G = CreateGroupByGenerators(zx, zx(1, 0), zx(0, 1))
# H = CreateGroupByGenerators(G, zx(1, 0))
# K = CreateQuotientGroup(G, H)

# DisplayDetails(G)
# DisplayDetails(H)
# println("#################")
# DisplayDetails(K)
# DisplayCosets(K)

s4 = Sn(4)
S4 = CreateGroupByGenerators(s4, s4([1, 2]), s4([1, 2, 3, 4]))
DisplayDetails(S4)

K4 = CreateGroupByGenerators(s4, s4([1, 3], [2, 4]), s4([1, 2], [3, 4]))
DisplayDetails(K4)

Q = CreateQuotientGroup(S4, K4)
DisplayDetails(Q)