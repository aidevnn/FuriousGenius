
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

println("bye.")
