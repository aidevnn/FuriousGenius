
@testset "Simples Operations on Zn" begin
    z5 = Zn(5)
    e1 = ZnInt(z5, 1)
    e2 = ZnInt(8, 5)

    @test e1 == ZnInt(11, 5)
    @test e1 * e2 == ZnInt(z5, 4)
    @test_throws ErrorException Zn(-5)
    @test_throws baseGroupEx e1 * ZnInt(1, 6)
end
