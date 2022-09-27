
using FuriousGenius

#############################################
#                                           #
#           Semi-Direct Product             #
#            of cyclics groups              #
#                                           #
#############################################

function Sdp(m::Int, p::Int)
    Zm = CreateGroupByGenerators(Zn(m), Zn(m)(1))
    Zp = CreateGroupByGenerators(Zn(p), Zn(p)(1))
    G = CreateSemiDirectProduct(Zm, Zp)
    DisplayDetails(G, "C$m ⋊ C$p")
    DisplayActions(G)
end

Sdp(4, 2)
Sdp(5, 2)
Sdp(7, 3)
Sdp(3, 4)
