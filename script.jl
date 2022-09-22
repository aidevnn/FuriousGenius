
using FuriousGenius

z10 = Zn(10)
z15 = Zn(15)

@show z10
@show z10(3)

z10xz15 = G2p{Zn,Zn}(z10, z15)
@show z10xz15
@show z10xz15(34, 51)

@show methods(z10)
@show methods(z10xz15)

arr0 = Set{E2p{Zn,Zn}}([Neutral(z10xz15)])
arr1 = Set{E2p{Zn,Zn}}([z10xz15(2, 0), z10xz15(0, 3)])
@show arr0
@show arr1

arr2 = Generate(z10xz15, arr0, arr1)
@show arr2

println("bye.")