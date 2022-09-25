
function Cosets(g::ConcreteGroup, h::ConcreteGroup)::Set{Set{Elt}}
    if !(issubset(h.elements, g.elements))
        throw(GroupException(NotSubGroupEx))
    end

    cosets = Set{Set{Elt}}()
    for x in g.elements
        xi = Invert(g, x)
        xH = Set{Elt}([Op(g, x, he) for he in h.elements])
        xHxi = Set([Op(g, xh, xi) for xh in xH])
        if !issetequal(h.elements, xHxi)
            throw(GroupException(NotNormalEx))
        end

        if all(s -> !issetequal(s, xH), cosets)
            push!(cosets, xH)
        end
    end

    return cosets
end

function DisplayCosets(cosets::Set{Set{Elt}})
    println("Cosets")
    sets = sort([cosets...], by=minimum)
    n = length(sets)
    for i = 1:n
        s = sets[i]
        e = minimum(s)
        v = sort([s...])
        println("($i) = $e")
        for ei in v
            println("   $ei")
        end
    end
    println()
end

function Representants(cosets::Set{Set{Elt}})::Dict{Elt,Elt}
    repr = Dict{Elt,Elt}()
    for s in cosets
        r = minimum(s)
        for e in s
            push!(repr, e => r)
        end
    end
    return repr
end
