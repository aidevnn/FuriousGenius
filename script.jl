
using FuriousGenius
using FuriousGenius: ByValue, ByOrder

ShowTable()

z2 = Zn(2)
z3 = Zn(3)
z4 = Zn(4)
s3 = Sn(3)
s4 = Sn(4)

S4 = CreateGroupByGenerators(s4, s4([1, 2]), s4([1:4...]))

K4 = CreateGroupByGenerators(s4, s4([1, 3], [2, 4]), s4([1, 2], [3, 4]))
DisplayDetails(K4, "K4")

S3 = CreateGroupByGenerators(s3, s3([1, 2]), s3([1, 2, 3]))
DisplayDetails(S3, "S3")

zx = Gp{3}(z2, z2, z3)
gx = CreateGroupByGenerators(zx, zx(1, 0, 0), zx(0, 1, 0), zx(0, 0, 1))
DisplayDetails(gx)

zx = Gp{2}(z3, z4)
gx = CreateGroupByGenerators(zx, zx(1, 0), zx(0, 1))
DisplayDetails(gx)

S4 = CreateGroupByGenerators(s4, s4([1, 2]), s4([1:4...]))
A4 = CreateGroupByGenerators(S4, s4([1, 3], [2, 4]), s4([1, 2, 3]))
DisplayDetails(A4, "A4")
