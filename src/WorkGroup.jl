
struct EltOrder
    i::Int
    e::Elt
    o::Int
end

Base.show(io::IO, eo::EltOrder) = print(io, "($(eo.i)) = $(eo.e)[$(eo.o)]")

function CreateGroupByGenerators(g::FGroup, vs::Vararg{Elt})::ConcreteGroup
    vs0 = Set{Elt}([vs...])
    if g isa ConcreteGroup
        if any(e -> !(e in g.elements), vs0)
            throw(GroupException(SubGroupElementEx))
        end
    end

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

function DisplayElements(g::ConcreteGroup, sortby::SortElement=ByOrder)
    println("Elements")
    n = length(g.elements)
    digitsOrders = maximum(e -> length("$(g.orders[e])"), g.elements)
    digitsName = maximum(e -> length("$e"), [1:n...])
    fmt = "({1:$(digitsName)d})[{2:$(digitsOrders)d}] = {3}"
    set = Vector{Elt}()
    if sortby == ByOrder
        set = sort(g.elements, by=e -> (g.orders[e], e))
    else
        set = sort(g.elements)
    end

    for i = 1:n
        e = set[i]
        o = g.orders[e]
        printfmtln(fmt, i, o, e)
    end

    println()
end

function DisplayTable(g::ConcreteGroup, sortby::SortElement=ByOrder)
    println("Table")
    n = length(g.elements)
    digitsName = maximum(e -> length("$e"), [1:n...])
    fmt = " {1:$(digitsName)d}"
    set = Vector{Elt}()
    if sortby == ByOrder
        set = sort(g.elements, by=e -> (g.orders[e], e))
    else
        set = sort(g.elements)
    end
    dicEltInt = Dict{Elt,Int}([set[i] => i for i = 1:n])
    dicIntElt = Dict{Int,Elt}([i => set[i] for i = 1:n])
    for i = 1:n
        s = ""
        for j = 1:n
            e = dicEltInt[Op(g, dicIntElt[i], dicIntElt[j])]
            s *= format(fmt, e)
        end
        println(s)
    end

    println()
end

function DisplayHead(g::ConcreteGroup, name::String="G")
    println("|$name| = ", length(g.elements))
    println(g.groupType)
    println("BaseGroup : ", g.baseGroup)
    println()
end

function DisplayHeadElements(g::ConcreteGroup, name::String="G", sortby::SortElement=ByOrder)
    DisplayHead(g, name)
    DisplayElements(g, sortby)
end

function DisplayHeadTable(g::ConcreteGroup, name::String="G", sortby::SortElement=ByOrder)
    DisplayHead(g, name)
    DisplayTable(g, sortby)
end

function DisplayDetails(g::ConcreteGroup, name::String="G", sortby::SortElement=ByOrder)
    DisplayHead(g, name)
    DisplayElements(g, sortby)
    DisplayTable(g, sortby)
end
