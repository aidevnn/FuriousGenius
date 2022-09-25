module FuriousGenius

using UUIDs
using Exceptions
using Formatting

export ExceptionType, GroupType, PermutationForm, SortElement

export GroupException

export CyclesToPermutation, PermutationToCycles, AllPerms

export Elt, FGroup, CGroup, Neutral, Invert, Op, BaseGroup,
    GetHash, GetString, Times, baseGroupEx, IsLess, allsame
export GetElements, SetElements, GetMonogenics, SetMonogenics,
    GetOrders, SetOrders, GetGroupType, SetGroupType

export Gp, Ep

export Generate, Monogenic, Generators, ElementOrder, IsAbelian, ConcreteGroup

export CreateGroupByGenerators, DisplayElements, DisplayTable,
    DisplayHead, DisplayHeadElements, DisplayHeadTable, DisplayDetails

export Cosets, DisplayCosets, Representants, QuotientGroup, CreateQuotientGroup

export DirectProduct

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
include("DirectProduct.jl")
include("Zn.jl")
include("Sn.jl")

end # module
