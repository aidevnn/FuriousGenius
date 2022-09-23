using Test
using FuriousGenius

@testset "Zn Basics" begin
    z5 = Zn(5)
    e1 = z5(1)
    @testset "Throwing Exceptions" begin
        @test_throws GroupException Zn(-5)
        @test_throws GroupException Invert(z5, ZnInt(2, 7))
        @test_throws GroupException Op(z5, e1, ZnInt(1, 6))
        @test_throws GroupException Times(z5, ZnInt(2, 7), 2)
        @test_throws GroupException IsLess(e1, ZnInt(1, 6))
    end

    e2 = ZnInt(3, 5)
    @testset "Create elements and groups" begin
        @test e1 == z5(11)
        @test Op(z5, e1, e2) == z5(4)
        @test Invert(z5, e2) == z5(2)
        @test Times(z5, e2, 4) == z5(2)
        @test Times(z5, e2, -2) == z5(4)
        @test BaseGroup(ZnInt(4, 5)) == z5
        @test BaseGroup(ZnInt(1, 3)) == Zn(3)
        @test BaseGroup(ZnInt(0, 3)) != z5
    end

    z7 = Zn(7)
    set = Set{ZnInt}([e1, e2, z5(13), z5(21), z5(48)])
    arr1 = [z7(4), z7(2), z7(5), z7(1), z7(2)]
    arr2 = [z7(1), z7(2), z7(2), z7(4), z7(5)]
    arr3 = [z7(1), z7(2), ZnInt(3, 7), z7(4), z7(5)]
    @testset "Sets of group elements" begin
        @test length(set) == 2
        @test all(isequal.(sort(arr1), arr2))
        @test !all(isequal.(arr2, arr3))
    end
end

@testset "Zm x Zn" begin
    z4 = Zn(4)
    z8 = Zn(8)
    z15 = Zn(15)
    z8xz15 = Gp{2}(z8, z15)
    e1 = ZnInt(z8, 3)
    e2 = ZnInt(z15, 5)
    ep0 = Ep{2}(e1, e2)
    ep1 = Ep{2}(e1, e2)
    ep2 = Ep{2}(z8(4), z15(3))

    @testset "Create tuples" begin
        @test z8xz15.c[1] == z8
        @test z8xz15.c[2] == z15
        @test ep0.c[1] == e1
        @test ep0.c[2] == e2
        @test BaseGroup(ep0) == z8xz15
        @test BaseGroup(ep1) == z8xz15
        @test ep0 == ep1
    end

    @testset "Ops" begin
        @test Invert(z8xz15, ep0) == Ep{2}(z8(5), z15(10))
        @test Op(z8xz15, ep0, ep2) == Ep{2}(z8(7), z15(8))
        @test Times(z8xz15, ep0, 24) == Neutral(z8xz15)
        @test Times(z8xz15, ep0, 25) != Neutral(z8xz15)
    end

    z4xz8xz15 = Gp{3}(z4, z8, z15)
    e0 = Ep{3}(z4(3), z8(7), z15(4))
    e1 = z4xz8xz15(1, 5, 8)
    @testset "Zm x Zn x Zo" begin
        @test Invert(z4xz8xz15, e0) == z4xz8xz15(1, 1, 11)
        @test Op(z4xz8xz15, e0, e1) == z4xz8xz15(0, 4, 12)
        @test Times(z4xz8xz15, z4xz8xz15(2, 4, 5), 6) == Neutral(z4xz8xz15)
    end
end

@testset "Concrete Grp" begin
    z4xz4 = Gp{2}(Zn(4), Zn(4))
    arr0 = Set{Elt}([Neutral(z4xz4)])
    arr1 = Set{Elt}([z4xz4(2, 0), z4xz4(0, 1)])
    arr2 = Generate(z4xz4, arr0, arr1)
    arr3 = Set{Elt}([z4xz4(2 * i, j) for i = 1:2, j = 1:4])
    @testset "Direct Product" begin
        @test length(arr2) == 8
        @test issetequal(arr2, arr3)
    end

    g = Gp{2}(Zn(2), Zn(4))
    it1 = Monogenic(g, g(1, 1))
    it2 = Dict{Elt,Int}(g(1, 1) => 1, g(0, 2) => 2, g(1, 3) => 3, g(0, 0) => 4)
    @testset "Monogenic" begin
        @test length(it1) == 4
        @test issetequal(it1, it2)
    end

    void = Set{Elt}([Neutral(g)])
    gs = Set{Elt}([g(1, 0), g(0, 1)])
    elts = Generate(g, void, gs)
    gens = Generators(g, elts)
    orders = ElementOrder(gens)
    validOrders = Dict{Elt,Int}(
        g(0, 0) => 1, g(1, 0) => 2,
        g(0, 2) => 2, g(1, 2) => 2,
        g(1, 3) => 4, g(1, 1) => 4,
        g(0, 1) => 4, g(0, 3) => 4)

    @testset "Generators and Orders" begin
        @test length(gens) == 4
        @test issetequal(gens[g(1, 0)], Dict{Elt,Int}(g(1, 0) => 1, g(0, 0) => 2))
        @test issetequal(gens[g(1, 2)], Dict{Elt,Int}(g(1, 2) => 1, g(0, 0) => 2))
        @test issetequal(gens[g(0, 1)], Dict{Elt,Int}(g(0, 1) => 1, g(0, 2) => 2, g(0, 3) => 3, g(0, 0) => 4))
        @test issetequal(gens[g(1, 1)], Dict{Elt,Int}(g(1, 1) => 1, g(0, 2) => 2, g(1, 3) => 3, g(0, 0) => 4))
        @test length(orders) == 8
        @test issetequal(orders, validOrders)
    end

    cg0 = ConcreteGroup(Zn(20))
    cg1 = ConcreteGroup(cg0)
    cg2 = ConcreteGroup(cg1)
    @testset "ConcreteGroup Ctor" begin
        @test isnothing(cg0.superGroup)
        @test !isnothing(cg1.superGroup)
        @test !isnothing(cg2.superGroup)
        @test cg0.baseGroup == cg1.baseGroup
        @test cg0.baseGroup == cg2.baseGroup
        @test cg0 == cg1.superGroup
        @test cg1 == cg2.superGroup
    end
end