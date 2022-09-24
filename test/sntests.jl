
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
