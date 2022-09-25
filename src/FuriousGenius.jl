module FuriousGenius

using UUIDs
using Exceptions
using Formatting

export ExceptionType, GroupType, PermutationForm, SortElement

export GroupException

export CyclesToPermutation, PermutationToCycles, AllPerms

export Elt, FGroup, Neutral, Invert, Op, BaseGroup,
    GetHash, GetString, Times, baseGroupEx, IsLess, allsame

export Gp, Ep

export Generate, Monogenic, Generators, ElementOrder, IsAbelian, ConcreteGroup

export CreateGroupByGenerators, EltOrder, DisplayElements, DisplayTable,
    DisplayHead, DisplayHeadElements, DisplayHeadTable, DisplayDetails

export Cosets, DisplayCosets, Representants

export ZnInt, Zn

export Perm, Sn, ShowTable, ShowCycles

include("Enumerations.jl")
include("GroupException.jl")
include("Permutations.jl")
include("GroupTheory.jl")
include("GroupTuples.jl")
include("ConcreteGroup.jl")
include("WorkGroup.jl")
include("QuotientGroup.jl")
include("Zn.jl")
include("Sn.jl")

end # module
