
@testset "Cycles<->Perm" begin
    @testset "Cycles->Perm" begin
        @test CyclesToPermutation(0, [[1, 3]]) == [1]
        @test CyclesToPermutation(5, [[1, 3, 3]]) == [1, 2, 3, 4, 5]
        @test CyclesToPermutation(5, [[1, 3]]) == [3, 2, 1, 4, 5]
        @test CyclesToPermutation(5, [[1, 3, 5]]) == [3, 2, 5, 4, 1]
        @test CyclesToPermutation(5, [[1, 3], [2, 4, 5]]) == [3, 4, 1, 5, 2]
    end

    @testset "Perm->Cycles" begin
        @test PermutationToCycles(0, [3, 1, 5, 2]) == Vector{Vector{Int}}()
        @test PermutationToCycles(5, [3, 1, 5, 2]) == Vector{Vector{Int}}()
        @test PermutationToCycles(5, [3, 2, 1, 4, 5]) == [[1, 3]]
        @test PermutationToCycles(5, [3, 2, 5, 4, 1]) == [[1, 3, 5]]
        @test PermutationToCycles(5, [3, 4, 1, 5, 2]) == [[1, 3], [2, 4, 5]]
    end

    AllPerms(7)
    @testset "All Perms" begin
        @test length(AllPerms(2)) == 2
        @test length(AllPerms(3)) == 6
        @test length(AllPerms(4)) == 24
        @test length(AllPerms(5)) == 120
        @test length(AllPerms(6)) == 720
        @test length(AllPerms(7)) == 5040
    end
end

@testset "Sn Basics" begin
    s3 = Sn(3)
    s4 = Sn(4)
    e1 = s4([1, 2, 4])
    @testset "Throwing Exceptions" begin
        @test_throws GroupException Sn(-5)
        @test_throws GroupException Invert(s3, s4([4, 2, 1]))
        @test_throws GroupException Op(s4, e1, s3([1, 2]))
        @test_throws GroupException Times(s4, s3([1, 2]), 2)
        @test_throws GroupException IsLess(e1, s3([1, 2]))
    end

    e2 = s4([1, 2])
    @testset "Create elements and groups" begin
        @test e1 == s4([2, 4, 1])
        @test Op(s4, e1, e2) == s4([1, 4])
        @test Invert(s4, e2) == e2
        @test Times(s4, e1, 2) == s4([1, 4, 2])
        @test Times(s4, e1, -2) == s4([1, 2, 4])
        @test BaseGroup(e1) == s4
        @test BaseGroup(s3([1, 2])) == s3
        @test BaseGroup(e1) != s3
    end
end

@testset "Sn Generate" begin
    s3 = Sn(3)
    s4 = Sn(4)
    s5 = Sn(5)
    s6 = Sn(6)
    S3 = CreateGroupByGenerators(s3, s3([1, 2]), s3([1, 2, 3]))
    S4 = CreateGroupByGenerators(s4, s4([1, 2]), s4([1:4...]))
    S5 = CreateGroupByGenerators(s5, s5([1, 2]), s5([1:5...]))
    S6 = CreateGroupByGenerators(s6, s6([1, 2]), s6([1:6...]))
    @test length(GetElements(S3)) == 6
    @test length(GetElements(S4)) == 24
    @test length(GetElements(S5)) == 120
    @test length(GetElements(S6)) == 720

    @test issetequal([e.p for e in GetElements(S3)], AllPerms(3))
    @test issetequal([e.p for e in GetElements(S4)], AllPerms(4))
    @test issetequal([e.p for e in GetElements(S5)], AllPerms(5))
    @test issetequal([e.p for e in GetElements(S6)], AllPerms(6))

    @test length(GetMonogenics(S3)) == 4
    @test length(GetMonogenics(S4)) == 13
    @test length(GetMonogenics(S5)) == 31
    @test length(GetMonogenics(S6)) == 246

    A4 = CreateGroupByGenerators(S4, s4([1, 3], [2, 4]), s4([1, 2, 3]))
    @test length(GetElements(A4)) == 12
    @test_throws GroupException CreateGroupByGenerators(A4, s4([1:4...]))
end
