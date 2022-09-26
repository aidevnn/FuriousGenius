using BenchmarkTools
using FuriousGenius

#############################################
#                                           #
#   Work script for crafting new functions  #
#   or before adding new unit test          #
#                                           #
#############################################

ShowTable()
s4 = Sn(4)

S4 = CreateGroupByGenerators(s4, s4([1, 2, 3, 4]), s4([1, 2]))
A4 = CreateGroupByGenerators(S4, s4([4, 2, 3]), s4([1, 3], [2, 4]))
V = CreateGroupByGenerators(S4, s4([1, 2], [3, 4]), s4([1, 3], [2, 4]))
# DisplayHeadElements(A4, "A4")
# DisplayHeadElements(V, "V")

# Q = CreateQuotientGroup(S4, V)
# DisplayHeadElements(Q, "S4/V")
# DisplayCosets(Q)

Z2 = CreateGroupByGenerators(Zn(2), Zn(2)(1))
Z3 = CreateGroupByGenerators(Zn(3), Zn(3)(1))
G = DirectProduct(Gp{2}(Z2, A4))
# DisplayHeadElements(G)

z40 = Zn(40)
Z20 = CreateGroupByGenerators(z40, z40(2))
Z4 = CreateGroupByGenerators(z40, z40(10))
Q = CreateQuotientGroup(Z20, Z4)
DisplayHeadElements(Q, "Q")
H = DirectProduct(Gp{2}(Z3, Q))
DisplayHeadElements(H, "H")
