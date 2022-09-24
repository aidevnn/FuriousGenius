module FuriousGenius

using UUIDs
using Exceptions

export ExceptionType, GroupType, PermutationForm

export GroupException

export Elt, FGroup, Neutral, Invert, Op, BaseGroup,
    GetHash, GetString, Times, baseGroupEx, IsLess, allsame

export Gp, Ep

export ZnInt, Zn

export CreateGroupByGenerators, EltOrder

export Generate, Monogenic, Generators, ElementOrder, IsAbelian, ConcreteGroup

export CyclesToPermutation, PermutationToCycles, AllPerms

export Perm, Sn, ShowTable, ShowCycles, permForm

include("Enumerations.jl")
include("GroupException.jl")
include("GroupTheory.jl")
include("GroupTuples.jl")
include("ConcreteGroup.jl")
include("WorkGroup.jl")
include("Permutations.jl")
include("Zn.jl")
include("Sn.jl")

end # module
