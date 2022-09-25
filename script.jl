
using FuriousGenius

#############################################
#                                           #
#   Work script for crafting new functions  #
#   or before adding new unit test          #
#                                           #
#############################################

s4 = Sn(4)
S4 = CreateGroupByGenerators(s4, s4([1, 2]), s4([1, 2, 3, 4]))
A4 = CreateGroupByGenerators(s4, s4([1, 3], [2, 4]), s4([1, 2], [3, 4]), s4([1, 2, 3]))
C3 = CreateGroupByGenerators(s4, s4([1, 2, 3]))
C4 = CreateGroupByGenerators(s4, s4([1, 2, 3, 4]))
V = CreateGroupByGenerators(s4, s4([1, 3], [2, 4]), s4([1, 2], [3, 4]))
K = CreateGroupByGenerators(s4, s4([1, 2]), s4([3, 4]))
Q1 = CreateQuotientGroup(S4, V)
Q2 = CreateQuotientGroup(A4, V)