
export Generate

function Generate(g::T, leftOp::Set{Elt{T}}, rightOp::Set{Elt{T}})::Set{Elt{T}} where {T<:FGroup}
    n = Neutral(g)
    if length(rightOp) == 0
        return Set{Elt{T}}(n)
    end

    all = Set{Elt{T}}(leftOp)
    q = Vector{Elt{T}}(collect(leftOp))
    pushfirst!(q, n)

    while length(q) != 0
        e0 = popfirst!(q)
        for e1 in rightOp
            e2 = Op(g, e0, e1)
            if !(e2 in all)
                push!(all, e2)
                pushfirst!(q, e2)
            end
        end
    end

    return all
end
