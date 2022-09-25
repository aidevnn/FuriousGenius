
function DirectProduct(H::CGroup, K::CGroup)::CGroup
    if isnothing(H.superGroup) || H.superGroup != K.superGroup
        throw(GroupException(SuperGroupEx))
    end

    set = Set{Elt}()
    push!(set, keys(GetMonogenics(H))...)
    push!(set, keys(GetMonogenics(K))...)
    return CreateGroupByGenerators(H.superGroup, set...)
end
