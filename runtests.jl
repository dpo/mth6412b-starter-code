include("mainphase1.jl")

Gtest = Graph("Gtest", [Node("1", [0, 0]),
Node("2", [0, 0]),
Node("3", [0, 0]),
Node("4", [0, 0]),
Node("5", [0, 0]),
Node("6", [0, 0])],
[Edge("1↔2", (1, 2), 2),
Edge("2↔4", (2, 4), 4),
Edge("4↔6", (4, 6), 2),
Edge("6↔5", (6, 5), 2),
Edge("5↔3", (5, 3), 3),
Edge("1↔3", (1, 3), 13),
Edge("2↔3", (2, 3), 1),
Edge("4↔5", (4, 5), 3)])

function kruskal2(graph::Graph{T, I}) where{T, I}
    # Triage des arètes du graphe en ordre croissant des poids
    weights = I[]
    for e in graph.edges
        push!(weights, e.weight)
    end
    perms = sortperm(weights)
    permute!(graph.edges, perms)
    graph

    #Construction de l'arbre A
    A = Edge{I}[]
    SC = [Int64[]]
    for i in 1:length(graph.nodes)
        push!(SC, Int64[parse(I, graph.nodes[i].name)])
    end

    composantes = [0, 0]
    for edge1 in graph.edges
        si = edge1.data[1]
        sj = edge1.data[2]
        composantes .= 0
        for i in 1:length(SC)
            for s in SC[i]
                if s == si
                    composantes[1] = i
                elseif s == sj
                    composantes[2] = i
                end
            end
        end
        if composantes[1] != composantes[2]
            push!(A, edge1)
            for edge2 in SC[composantes[1]]
                push!(SC[composantes[2]], edge2)
            end
            deleteat!(SC, composantes[1])
        end
    end
    A
end

#kruskal2(Gtest)