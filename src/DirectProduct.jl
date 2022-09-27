
function DirectProduct(H::CGroup, K::CGroup)::CGroup
    if H isa QuotientGroup || K isa QuotientGroup || isnothing(H.superGroup) || H.superGroup != K.superGroup
        throw(GroupException(SuperGroupEx))
    end

    set = Set{Elt}()
    push!(set, keys(GetMonogenics(H))...)
    push!(set, keys(GetMonogenics(K))...)
    return CreateGroupByGenerators(H.superGroup, set...)
end

function DirectProduct(gp::Gp{N})::CGroup where {N}
    if any(g -> !(g isa CGroup), gp.c)
        throw(GroupException(GroupDefinitionEx))
    end

    fgens = Set{Elt}()
    tn = Vector{Elt}([Neutral(gp).c...])
    for i = 1:N
        bgens = Vector{Elt}(collect(keys(gp.c[i].monogenics)))
        for e in bgens
            t0 = Vector{Elt}(tn)
            t0[i] = e
            push!(fgens, Ep{N}(Tuple(t0)))
        end
    end

    elements = Generate(gp, fgens)
    monogenics = Generators(gp, elements)
    grouptype = IsAbelian(gp, collect(keys(monogenics))) ? AbelianGroup : NonAbelianGroup
    orders = ElementOrder(monogenics)

    bgr = Gp{N}(Tuple([gc.baseGroup for gc in gp.c]))
    gr = ConcreteGroup(bgr)
    gr.superGroup = ConcreteGroup(gp)

    SetElements(gr, elements)
    SetMonogenics(gr, monogenics)
    SetOrders(gr, orders)
    SetGroupType(gr, grouptype)

    return gr
end
