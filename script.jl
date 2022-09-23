
using FuriousGenius

z5 = Zn(5)
z8 = Zn(8)
z10 = Zn(10)
z15 = Zn(15)
z5xz10xz15 = Gp{3}(z5, z10, z15)
z8xz10 = Gp{2}(z8, z10)

# @show z10
# @show z10(3)

# z10xz15 = Gp{2}(z10, z15)
# @show z10xz15
# @show z10xz15(34, 51)

# @show methods(z10)
# @show methods(z10xz15)

# arr0 = Set{Elt}([Neutral(z10xz15)])
# arr1 = Set{Elt}([z10xz15(2, 0), z10xz15(0, 3)])
# @show arr0
# @show arr1

# arr2 = Generate(z10xz15, arr0, arr1)
# @show arr2

# @show z5xz10xz15
# @show Neutral(z5xz10xz15)
# e0 = Ep{3}(z5(3), z10(7), z15(4))
# e1 = z5xz10xz15(1, 5, 8)
# @show e0
# @show e1
# @show Invert(z5xz10xz15, e0)
# @show Op(z5xz10xz15, e0, e1)
# @show Times(z5xz10xz15, e1, 4);

# println()
# m = 2
# n = 4
# zMxzN = Gp{2}(Zn(m), Zn(n))

# m = Monogenic(zMxzN, zMxzN(1, 3))
# for e in sort(collect(m), by=x -> x[2])
#     println("$(e.first) => $(e.second)")
# end

# println()

# void = Set{Elt}([Neutral(zMxzN)])
# gs = Set{Elt}([zMxzN(1, 0), zMxzN(0, 1)])
# elts = Generate(zMxzN, void, gs)
# gens = Generators(zMxzN, elts)

# for p in sort(collect(gens), by=x -> (length(x[2]), x[1]))
#     @show p.first length(p.second)
#     for e in sort(collect(p.second), by=x -> x[2])
#         print("[$(e.first), $(e.second)] ")
#     end
#     println()
# end

# orders = ElementOrder(gens)
# println("Element Order")
# for e in sort(collect(orders), by=x -> x[2])
#     println("[$(e.first), $(e.second)] ")
# end

cg0 = ConcreteGroup(z5)
cg1 = ConcreteGroup(cg0)
@show cg0
@show cg0.baseGroup
@show cg0.superGroup
@show GetHash(cg0)
@show cg1
@show cg1.baseGroup
@show cg1.superGroup
@show GetHash(cg1)
@show Invert(cg0, z5(2))

println("bye.")