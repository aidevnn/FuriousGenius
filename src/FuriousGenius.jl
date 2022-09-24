module FuriousGenius

using UUIDs
using Exceptions

export ExceptionType, GroupType

export GroupException

export Elt, FGroup, Neutral, Invert, Op, BaseGroup,
    GetHash, GetString, Times, baseGroupEx, IsLess, allsame

export Gp, Ep

export ZnInt, Zn

export CreateGroupElements, EltOrder

export Generate, Monogenic, Generators, ElementOrder, IsAbelian, ConcreteGroup

export CyclesToPermutation, PermutationToCycles

export Perm, Sn

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
