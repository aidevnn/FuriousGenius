
using FuriousGenius

#############################################
#                                           #
#   Work script for crafting new functions  #
#   or before adding new unit test          #
#                                           #
#############################################

ShowCycles()

s4 = Sn(4)
S4 = CreateGroupByGenerators(s4, s4([1, 2]), s4([1, 2, 3, 4]))
C2 = CreateGroupByGenerators(S4, s4([1, 2]))
A4 = CreateGroupByGenerators(S4, s4([1, 3], [2, 4]), s4([1, 2], [3, 4]), s4([1, 2, 3]))
C2 = CreateGroupByGenerators(S4, s4([1, 2]))
C3 = CreateGroupByGenerators(S4, s4([1, 2, 3]))
C4 = CreateGroupByGenerators(S4, s4([1, 2, 3, 4]))
V = CreateGroupByGenerators(S4, s4([1, 3], [2, 4]), s4([1, 2], [3, 4]))
K = CreateGroupByGenerators(S4, s4([1, 2]), s4([3, 4]))
Q1 = CreateQuotientGroup(S4, V)
Q2 = CreateQuotientGroup(A4, V)

# DisplayDetails(Q2)
# DisplayCosets(Q2)
# for (e, s) in GetMonogenics(Q2)
#     @show e
#     display(sort([s...], by=x -> x[2]))
#     println()
# end

DP = DirectProduct(C2, C3)
DisplayDetails(DP)
@show s4([])