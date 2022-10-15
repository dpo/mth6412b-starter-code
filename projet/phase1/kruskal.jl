include("comp.jl")

function kruskal(graph::Graph{T}) where T
    A = sort(edges(graph), by = x -> weight(x))
    tree = []
    liste_comp = []
    for i = 1 : length(nodes(graph))
        n = nodes(graph)[i]
        push!(liste_comp, Comp(n, [(n, n)]))
    end
    for i = 1 : length(A)
        n1, n2 = nodes(A[i])
        k1 = findfirst(x -> in_comp(x, n1), liste_comp)
        k2 = findfirst(x -> in_comp(x, n2), liste_comp)
        if k1 != k2
            push!(tree, A[i])
            c1 = liste_comp[k1]
            c2 = liste_comp[k2]
            liste_comp[k1] = merge!(c1, c2)
            nouv_comp = liste_comp[k1]
            deleteat!(liste_comp, k2)
            @test in_comp(nouv_comp,n1)
            @test in_comp(nouv_comp,n2) #Ces deux tests vérifient que n1 et n2 font bien parties de cette nouvelle composante connexe
        end
    end
    return tree
end