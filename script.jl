
using FuriousGenius

z5 = Zn(5)
z8 = Zn(8)
z10 = Zn(10)
z15 = Zn(15)
z5xz10xz15 = Gp{3}(z5, z10, z15)
z8xz10 = Gp{2}(z8, z10)

@show z10
@show z10(3)

z10xz15 = Gp{2}(z10, z15)
@show z10xz15
@show z10xz15(34, 51)

@show methods(z10)
@show methods(z10xz15)

arr0 = Set{Elt}([Neutral(z10xz15)])
arr1 = Set{Elt}([z10xz15(2, 0), z10xz15(0, 3)])
@show arr0
@show arr1

arr2 = Generate(z10xz15, arr0, arr1)
@show arr2

@show z5xz10xz15
@show Neutral(z5xz10xz15)
e0 = Ep{3}(z5(3), z10(7), z15(4))
e1 = z5xz10xz15(1, 5, 8)
@show e0
@show e1
@show Invert(z5xz10xz15, e0)
@show Op(z5xz10xz15, e0, e1)
@show Times(z5xz10xz15, e1, 4);

println()

g = z8xz10(2, 2)
v0 = Monogenic(z8xz10, g)
v1 = Monogenic(z8xz10, z8xz10(4, 4))
@show z8xz10
# @show g
# for e in v0
#     println(e)
# end

@show intersect(v0, v1)

@show intersect(v1, v0)


println("bye.")