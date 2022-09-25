
@testset "QuoGroup" begin
    @testset "Abelians" begin
        z40 = Zn(40)
        Z20 = CreateGroupByGenerators(z40, z40(2))
        Z4 = CreateGroupByGenerators(z40, z40(10))
        Z8 = CreateGroupByGenerators(z40, z40(5))

        @test_throws GroupException CreateQuotientGroup(Z20, Z8)
        quo = CreateQuotientGroup(Z20, Z4)
        for p in quo.representants
            @test mod(p[1].k, 10) == p[2].k
        end

        zx = Gp{2}(Zn(20), Zn(30))
        G = CreateGroupByGenerators(zx, zx(1, 0), zx(0, 1))
        H = CreateGroupByGenerators(zx, zx(1, 1))
        K = CreateQuotientGroup(G, H)
        @test length(GetElements(K)) == 10
    end

    @testset "Symmetric Group" begin
        s4 = Sn(4)
        S4 = CreateGroupByGenerators(s4, s4([1, 2]), s4([1, 2, 3, 4]))
        A4 = CreateGroupByGenerators(s4, s4([1, 3], [2, 4]), s4([1, 2], [3, 4]), s4([1, 2, 3]))
        C3 = CreateGroupByGenerators(s4, s4([1, 2, 3]))
        C4 = CreateGroupByGenerators(s4, s4([1, 2, 3, 4]))
        V = CreateGroupByGenerators(s4, s4([1, 3], [2, 4]), s4([1, 2], [3, 4]))
        K = CreateGroupByGenerators(s4, s4([1, 2]), s4([3, 4]))
        @test_throws GroupException CreateQuotientGroup(S4, C3)
        @test_throws GroupException CreateQuotientGroup(A4, C4)
        @test_throws GroupException CreateQuotientGroup(A4, K)

        Q1 = CreateQuotientGroup(S4, V)
        Q2 = CreateQuotientGroup(A4, V)
        @test length(GetElements(Q1)) == 6
        @test length(GetElements(Q2)) == 3
    end
end
