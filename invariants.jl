using FuriousGenius

function InvariantAndQuoGroup(g::CGroup)::CGroup
    m = minimum(e -> (-e[2], e[1]), GetOrders(g))
    maxOrderElt = (m[2], -m[1])
    NbElts = length(GetElements(g))
    @show NbElts
    @show maxOrderElt
    println()
    h = CreateGroupByGenerators(g, maxOrderElt[1])
    q = CreateQuotientGroup(g, h)
    return q
end

g = Gp{3}(Zn(8), Zn(18), Zn(30))
G = CreateGroupByGenerators(g, g(1, 0, 0), g(0, 1, 0), g(0, 0, 1))
G1 = InvariantAndQuoGroup(G)
G2 = InvariantAndQuoGroup(G1)
G3 = InvariantAndQuoGroup(G2)

dp = Gp{2}(CreateGroupByGenerators(Zn(20), Zn(20)(1)), CreateGroupByGenerators(Zn(30), Zn(30)(1)))
H = DirectProduct(dp)
H1 = InvariantAndQuoGroup(H)
H2 = InvariantAndQuoGroup(H1)
