using Test
using FuriousGenius

@testset "Zn Basics" begin
    z5 = Zn(5)
    e1 = z5(1)
    @testset "Throwing Exceptions" begin
        @test_throws ErrorException Zn(-5)
        @test_throws baseGroupEx Op(z5, e1, ZnInt(1, 6))
    end

    e2 = ZnInt(3, 5)
    @testset "Create elements and groups" begin
        @test e1 == ZnInt(11, 5)
        @test Op(z5, e1, e2) == ZnInt(z5, 4)
        @test Invert(z5, e2) == ZnInt(z5, 2)
        @test Times(z5, e2, 4) == ZnInt(z5, 2)
        @test Times(z5, e2, -2) == ZnInt(z5, 4)
        @test BaseGroup(ZnInt(4, 5)) == z5
        @test BaseGroup(ZnInt(1, 3)) == Zn(3)
        @test BaseGroup(ZnInt(0, 3)) != z5
    end

    set = Set{ZnInt}([e1, e2, ZnInt(13, 5), ZnInt(z5, 21), ZnInt(48, 5)])
    arr1 = [ZnInt(4, 7), ZnInt(2, 7), ZnInt(5, 7), ZnInt(1, 7), ZnInt(2, 7)]
    arr2 = [ZnInt(1, 7), ZnInt(2, 7), ZnInt(2, 7), ZnInt(4, 7), ZnInt(5, 7)]
    arr3 = [ZnInt(1, 7), ZnInt(2, 7), ZnInt(3, 7), ZnInt(4, 7), ZnInt(5, 7)]
    @testset "Sets of group elements" begin
        @test length(set) == 2
        @test all(isequal.(sort(arr1), arr2))
        @test !all(isequal.(arr2, arr3))
    end
end

@testset "Zm x Zn" begin
    z8 = Zn(8)
    z15 = Zn(15)
    z8xz15 = G2p{Zn,Zn}(z8, z15)
    e1 = ZnInt(z8, 3)
    e2 = ZnInt(z15, 5)
    ep0 = E2p{Zn,Zn}(e1, e2)
    ep1 = E2p{Zn,Zn}(z8xz15, e1, e2)
    ep2 = E2p{Zn,Zn}(z8(4), z15(3))

    @testset "Create tuples" begin
        @test z8xz15.g1 == z8
        @test z8xz15.g2 == z15
        @test ep0.e1 == e1
        @test ep0.e2 == e2
        @test BaseGroup(ep0) == z8xz15
        @test BaseGroup(ep1) == z8xz15
        @test ep0 == ep1
    end

    @testset "Ops" begin
        @test Invert(z8xz15, ep0) == E2p{Zn,Zn}(z8(5), z15(10))
        @test Op(z8xz15, ep0, ep2) == E2p{Zn,Zn}(z8(7), z15(8))
        @test Times(z8xz15, ep0, 24) == Neutral(z8xz15)
        @test Times(z8xz15, ep0, 25) != Neutral(z8xz15)
    end
end
