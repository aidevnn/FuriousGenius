module FuriousGenius

export Elt, FGroup, UserGroup, Neutral, Invert, Op, BaseGroup,
    GetHash, GetString, Times, baseGroupEx, IsLess, allsame

export G2p, E2p, BaseGroup, IsLess, GetHash, GetString, Neutral, Invert, Op

export ZnInt, Zn, Neutral, Invert, Op, BaseGroup, GetHash, GetString

export Generate

include("GroupTheory.jl")
include("GroupTuples.jl")
include("ConcreteGroup.jl")
include("Zn.jl")

end # module
