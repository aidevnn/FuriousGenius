
export Generate, Monogenic

struct OrderElt
    e::Elt
    g::Elt
    p::Int
    OrderElt(e::Elt) = new(e, e, 1)
    OrderElt(e::Elt, g::Elt, p::Int) = new(e, g, p)
end

Base.hash(o::OrderElt, h::UInt)::UInt = hash(GetHash(o.e), h)
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


# protected Dictionary<Order, HashSet<Order>> ComputeGenerators(IEnumerable<T> elements)
# {
#     var ne = this.Neutral();
#     HashSet<Order> set = new(elements.Select(e => new Order(e)));
#     Dictionary<Order, HashSet<Order>> gens = new();

#     while (set.Count != 0)
#     {
#         var e = set.First();
#         var g = Monogenic(e.e);
#         set.ExceptWith(g);
#         if (gens.Count == 0)
#         {
#             gens[e] = g;
#             continue;
#         }

#         var gens0 = new Dictionary<Order, HashSet<Order>>(gens);
#         gens.Clear();
#         bool found = false;
#         foreach (var p in gens0)
#         {
#             var e0 = p.Key;
#             var g0 = p.Value;

#             if (g.Count > g0.Count)
#             {
#                 if (g.IsSupersetOf(g0))
#                 {
#                     if (!gens.ContainsKey(e))
#                     {
#                         gens[e] = g;
#                         found = true;
#                     }
#                 }
#                 else
#                     gens[e0] = g0;
#             }
#             else
#             {
#                 gens[e0] = g0;
#                 if (!found && g0.IsSubsetOf(g))
#                     found = true;
#             }
#         }

#         if (!found)
#             gens[e] = g;
#     }

#     return gens;
# }

function Generators(g::FGroup, elements::Set{Elt})
    n = Neutral(g)
    set = Set{OrderElt}([OrderElt(e) for e in element])
    gens = Dict{OrderElt,Set{OrderElt}}()

    while length(set) != 0
        e = set[1]
        s = Monogenic(g, e.e)
    end
end