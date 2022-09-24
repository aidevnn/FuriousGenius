
struct EltOrder
    i::Int
    e::Elt
    o::Int
end

Base.show(io::IO, eo::EltOrder) = print(io, "($(eo.i)) = $(eo.e)[$(eo.o)]")

function CreateGroupElements(g::FGroup, vs::Vararg{Elt})
    vs0 = Set{Elt}([vs...])
    elements = Generate(g, vs0)
    gens = Generators(g, elements)
    gt = IsAbelian(g, collect(keys(gens)))
    orders = ElementOrder(gens)

    gr = ConcreteGroup(g)
    empty!(gr.elements)
    for e in elements
        push!(gr.elements, e)
    end

    empty!(gr.monogenics)
    for p in gens
        push!(gr.monogenics, p)
    end

    empty!(gr.orders)
    for p in orders
        push!(gr.orders, p)
    end

    gr.groupType = gt ? AbelianGroup : NonAbelianGroup

    return gr
end