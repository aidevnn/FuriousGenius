
export Generate, Monogenic, Generators

struct OrderElt
    e::Elt
    g::Elt
    p::Int
    OrderElt(e::Elt) = new(e, e, 1)
    OrderElt(e::Elt, g::Elt, p::Int) = new(e, g, p)
end

Base.hash(o::OrderElt, h::UInt)::UInt = hash(GetHash(o.e), h)
Base.:(==)(o1::OrderElt, o2::OrderElt)::Bool = o1.e == o2.e
Base.isless(o1::OrderElt, o2::OrderElt)::Bool = o1.p == o2.p ? IsLess(o1.e, o2.e) : (o1.p < o2.p)
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

function Generators(g::FGroup, elements::Set{Elt})::Dict{OrderElt,Set{OrderElt}}
    n = Neutral(g)
    set = Vector{OrderElt}(sort([OrderElt(e) for e in elements]))
    gens = Dict{OrderElt,Set{OrderElt}}()

    @show set
    @show length(set)
    println()

    while length(set) != 0
        e = first(set)
        s = Monogenic(g, e.e)
        setdiff!(set, s)
        if length(gens) == 0
            gens[e] = s
            continue
        end

        gens0 = Dict{OrderElt,Set{OrderElt}}(gens)
        empty!(gens)
        done = false
        for p in gens0
            e0 = p.first
            s0 = p.second
            if length(s) <= length(s0)
                key = minimum(s0)
                gens[key] = s0
                if !done && e in s0
                    done = true
                end
            else
                if e0 in s
                    if !haskey(gens, e)
                        key = minimum(s)
                        gens[key] = s
                        done = true
                    end
                else
                    key = minimum(s0)
                    gens[key] = s0
                end
            end
        end

        if !done
            key = minimum(s)
            gens[key] = s
        end
    end

    return gens
end