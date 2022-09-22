
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

arr0 = Set{Elt{G2p{Zn,Zn}}}([z10xz15(i, 0) for i = 2:2:10])
arr1 = Set{Elt{G2p{Zn,Zn}}}([z10xz15(0, i) for i = 3:3:15])
@show arr0
@show arr1

arr2 = Generate(z10xz15, arr0, arr1)
@show arr2

println("bye.")