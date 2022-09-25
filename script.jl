using BenchmarkTools
using FuriousGenius

#############################################
#                                           #
#   Work script for crafting new functions  #
#   or before adding new unit test          #
#                                           #
#############################################

ShowTable()
z3 = Zn(3)
z4 = Zn(4)
z2 = Zn(2)
s4 = Sn(4)

bg = Gp{3}(s4, z2, z2)
e0 = bg([[1, 2], [4, 3]], 1, 0)
e1 = bg([[1, 3], [2, 4]], 0, 1)
e2 = bg([[1, 2, 3]], 0, 0)
g = CreateGroupByGenerators(bg, e0, e1, e2)
DisplayDetails(g)
