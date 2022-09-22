
export Generate, Monogenic

struct OrderElt
    e::Elt
    g::Elt
    p::Int
end

Base.hash(o::OrderElt, h::UInt)::UInt = GetHash(o.e)
Base.:(==)(o1::OrderElt, o2::OrderElt)::Bool = o1.e == o2.e
Base.isless(o1::OrderElt, o2::OrderElt)::Bool = o1.e == o2.e ? o1.p < o2.p : IsLess(o1.e, o2.e)
Base.show(io::IO, o::OrderElt) = print(io, "g^$(o.p)=$(o.e)")

function Generate(g::FGroup, leftOp::Set{Elt}, rightOp::Set{Elt})::Set{Elt}
    if length(leftOp) == 0 || length(rightOp) == 0
        return Set{Elt}()
    end

    n = Neutral(g)
    set = Set{Elt}(leftOp)
    q = Vector{Elt}(collect(leftOp))
    if (!(n in q))
        push!(q, n)
        push!(set, n)
    end

    while length(q) != 0
        e0 = pop!(q)
        for e1 in rightOp
            e2 = Op(g, e0, e1)
            if !(e2 in set)
                push!(set, e2)
                pushfirst!(q, e2)
            end
        end
    end

    return set
end

function Monogenic(g::FGroup, e::Elt)::Set{OrderElt}
    set = Set{OrderElt}()
    n = Neutral(g)
    e0 = e
    p = 1
    push!(set, OrderElt(e0, e, p))

    while e0 != n
        e0 = Op(g, e0, e)
        p += 1
        push!(set, OrderElt(e0, e, p))
    end
    return set
end