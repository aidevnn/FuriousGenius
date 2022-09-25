
function DisplayElements(g::CGroup, sortby::SortElement=ByOrder)
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

function DisplayTable(g::CGroup, sortby::SortElement=ByOrder)
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

function DisplayHead(g::CGroup, name::String="G")
    println("|$name| = ", length(g.elements))
    println(g.groupType)
    println("BaseGroup : ", g.baseGroup)
    println()
end

function DisplayHeadElements(g::CGroup, name::String="G", sortby::SortElement=ByOrder)
    DisplayHead(g, name)
    DisplayElements(g, sortby)
end

function DisplayHeadTable(g::CGroup, name::String="G", sortby::SortElement=ByOrder)
    DisplayHead(g, name)
    DisplayTable(g, sortby)
end

function DisplayDetails(g::CGroup, name::String="G", sortby::SortElement=ByOrder)
    DisplayHead(g, name)
    DisplayElements(g, sortby)
    DisplayTable(g, sortby)
end
