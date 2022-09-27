
@testset "CGroups" begin
    @testset "Abelians" begin
        z40 = Zn(40)
        Z20 = CreateGroupByGenerators(z40, z40(2))
        Z8 = CreateGroupByGenerators(z40, z40(5))
        Z4 = CreateGroupByGenerators(z40, z40(10))
        @test length(GetElements(Z20)) == 20
        @test length(GetElements(Z8)) == 8
        @test length(GetElements(Z4)) == 4

        @test_throws GroupException CreateQuotientGroup(Z20, Z8)
        Q = CreateQuotientGroup(Z20, Z4)
        @test length(GetElements(Q)) == 5

        zx = Gp{2}(Zn(20), Zn(30))
        G = CreateGroupByGenerators(zx, zx(1, 0), zx(0, 1))
        H = CreateGroupByGenerators(zx, zx(1, 1))
        K = CreateQuotientGroup(G, H)
        @test length(GetElements(K)) == 10
    end

    @testset "Symmetric Group" begin
        s4 = Sn(4)
        S4 = CreateGroupByGenerators(s4, s4([1, 2]), s4([1, 2, 3, 4]))
        A4 = CreateGroupByGenerators(s4, s4([1, 3], [2, 4]), s4([1, 2, 3]))
        C3 = CreateGroupByGenerators(s4, s4([1, 2, 3]))
        C4 = CreateGroupByGenerators(s4, s4([1, 2, 3, 4]))
        V = CreateGroupByGenerators(s4, s4([1, 3], [2, 4]), s4([1, 2], [3, 4]))
        K = CreateGroupByGenerators(s4, s4([1, 2]), s4([3, 4]))
        @test_throws GroupException CreateQuotientGroup(S4, C3)
        @test_throws GroupException CreateQuotientGroup(A4, C4)
        @test_throws GroupException CreateQuotientGroup(A4, K)

        Q1 = CreateQuotientGroup(S4, V)
        Q2 = CreateQuotientGroup(A4, V)
        @test length(GetElements(S4)) == 24
        @test length(GetElements(A4)) == 12
        @test length(GetElements(V)) == 4
        @test length(GetElements(Q1)) == 6
        @test length(GetElements(Q2)) == 3
    end

    @testset "Nothing is useless" begin
        z2 = Zn(2)
        s4 = Sn(4)
        bg = Gp{3}(s4, z2, z2)
        e0 = bg([[1, 2], [4, 3]], 1, 0)
        e1 = bg([[1, 3], [2, 4]], 0, 1)
        g = CreateGroupByGenerators(bg, e0, e1)
        @test length(GetElements(g)) == 4
        @test GetGroupType(g) == FuriousGenius.AbelianGroup
    end

    @testset "Internal Direct Product" begin
        s4 = Sn(4)
        S4 = CreateGroupByGenerators(s4, s4([1, 2]), s4([1, 2, 3, 4]))
        C2 = CreateGroupByGenerators(s4, s4([1, 2]))
        C3 = CreateGroupByGenerators(s4, s4([1, 2, 3]))
        @test_throws GroupException DirectProduct(C2, C3)

        C2 = CreateGroupByGenerators(S4, s4([1, 2]))
        C3 = CreateGroupByGenerators(S4, s4([1, 2, 3]))
        DP = DirectProduct(C2, C3)
        elements = GetElements(DP)
        @test length(elements) == 6
        @test issubset([Neutral(s4), s4([1, 2]), s4([2, 3]), s4([1, 3]), s4([1, 2, 3]), s4([1, 3, 2])], elements)
    end

    @testset "External Direct Product" begin
        z2 = Zn(2)
        g = Gp{2}(z2, z2)
        H = CreateGroupByGenerators(z2, z2(1))
        @test length(GetElements(H)) == 2
        @test_throws GroupException DirectProduct(Gp{2}(H, z2))

        K = CreateGroupByGenerators(g, g(0, 1), g(1, 0))
        G0 = DirectProduct(Gp{2}(H, K))
        @test length(GetElements(K)) == 4
        @test length(GetElements(G0)) == 8

        G1 = DirectProduct(Gp{2}(H, H))
        @test length(GetElements(G1)) == 4

        z40 = Zn(40)
        Z20 = CreateGroupByGenerators(z40, z40(2))
        Z4 = CreateGroupByGenerators(z40, z40(10))
        Q = CreateQuotientGroup(Z20, Z4)
        G2 = DirectProduct(Gp{2}(H, Q))
        @test length(GetElements(Q)) == 5
        @test length(GetElements(G2)) == 10
    end

    @testset "Semi-direct Product" begin
        s4 = Sn(4)
        S3 = CreateGroupByGenerators(s4, s4([1, 2]), s4([1, 2, 3]))
        @test length(GetElements(S3)) == 6
        D8 = CreateGroupByGenerators(s4, s4([1, 2], [3, 4]), s4([1, 2, 3, 4]))
        @test length(GetElements(D8)) == 8

        z2 = Zn(2)
        z3 = Zn(3)
        z4 = Zn(4)
        Z2 = CreateGroupByGenerators(z2, z2(1))
        Z3 = CreateGroupByGenerators(z3, z3(1))
        Z4 = CreateGroupByGenerators(z4, z4(1))
        Z3sdpZ2 = CreateSemiDirectProduct(Z3, Z2)
        @test length(GetElements(Z3sdpZ2)) == 6
        Z4sdpZ2 = CreateSemiDirectProduct(Z4, Z2)
        @test length(GetElements(Z4sdpZ2)) == 8

        @test AreIsomorphic(S3, Z3sdpZ2)
        @test AreIsomorphic(D8, Z4sdpZ2)
    end
end
