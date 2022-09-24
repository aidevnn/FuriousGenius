
using FuriousGenius

z5 = Zn(5)
z8 = Zn(8)
z10 = Zn(10)
z15 = Zn(15)
z8xz10 = Gp{2}(z8, z10)
z5xz10xz15 = Gp{3}(z5, z10, z15)

# g = Gp{3}(Zn(4), Zn(6), Zn(8))
# wg = CreateGroupByGenerators(g, g(1, 0, 0), g(0, 1, 0), g(0, 0, 1))
# # @show wg.elements
# @show length(wg.elements)
# arr = sort([wg.monogenics...], by=p -> (length(p[2]), p[1]))
# n = length(arr)
# for i = 1:n
#     p = arr[i]
#     e = EltOrder(i, p[1], length(p[2]))
#     println(e)
# end

# S4 = CreateGroupByGenerators(s4, s4([1, 2]), s4([1, 2, 3, 4]))
# for e in sort(S4.elements)
#     @show e
# end

for n = 1:4
    Sn = AllPerms(n)
    total = length(Sn)
    @show n total Sn
    println()
end

s3 = Sn(3)
s4 = Sn(4)
s5 = Sn(5)

S3 = CreateGroupByGenerators(s3, s3([1, 2]), s3([1, 2, 3]))
S4 = CreateGroupByGenerators(s4, s4([1, 2]), s4([1, 2, 3, 4]))
S5 = CreateGroupByGenerators(s5, s5([1, 2]), s5([1, 2, 3, 4, 5]))

for x = 3:6
    sx = Sn(x)
    Sx = CreateGroupByGenerators(sx, sx([1, 2]), sx([1:x...]))
    monoGens = length(keys(Sx.monogenics))
    total = length(Sx.elements)
    @show sx, total, monoGens
    allPerms = AllPerms(x)
    @show issetequal([e.p for e in Sx.elements], allPerms)

end


println("bye.")
