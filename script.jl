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
DisplayHeadElements(A4, "A4")
DisplayHeadElements(V, "V")

Q = CreateQuotientGroup(S4, V)
DisplayHeadElements(Q, "S4/V")
DisplayCosets(Q)
