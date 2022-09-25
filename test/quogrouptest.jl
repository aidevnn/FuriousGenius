
@testset "QuoGroup" begin
    z40 = Zn(40)
    Z20 = CreateGroupByGenerators(z40, z40(2))
    Z4 = CreateGroupByGenerators(z40, z40(10))
    Z8 = CreateGroupByGenerators(z40, z40(5))

    @test_throws GroupException CreateQuotientGroup(Z20, Z8)
    quo = CreateQuotientGroup(Z20, Z4)
    for p in quo.representants
        @test mod(p[1].k, 10) == p[2].k
    end
end
