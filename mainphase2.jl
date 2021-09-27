using Plots
using Test
include("mainphase1.jl")

"""
Applique l'algorithme de Kruskal sur un graphe. Renvoie l'arbre de coût minimum recouvrant le graphe.
"""
function kruskal(graph::Graph{T, I, J}) where{T, I, J}
    # Trier les arêtes du graphe en ordre croissant de poids.
    weights = J[]
    for e in graph.edges
        push!(weights, e.weight)
    end
    perms = sortperm(weights)
    permute!(graph.edges, perms)

    #Initialisation de l'arbre de coût minimum A
    #et de SC le vecteur des S, où S est une composante connexe de G.
    arbre = Edge{I, J}[]
    SC = ConnexComp{I}[]
    for i in 1:length(graph.nodes)
        if I <: AbstractString 
            push!(SC, ConnexComp(I[graph.nodes[i].name]))
        else
            push!(SC, ConnexComp(I[parse(I, graph.nodes[i].name)]))
        end
    end

    comp = [0, 0]
    for edge1 in graph.edges
        si = edge1.data[1]
        sj = edge1.data[2]
        comp .= 0
        for i in 1:length(SC)
            #Pour chaque arête [si, sj], on place l'indice par rapport à SC de la composante connexe contenant 
            #si et l'indice de sj dans la liste comp.
            for s in SC[i].nodenames
                if s == si
                    comp[1] = i
                elseif s == sj
                    comp[2] = i
                end
            end
        end
        #Si sj et si sont dans des composantes distinctes, on ajoute l'arète à l'arbre
        #et on fusionne les deux composantes connexes.
        if comp[1] != comp[2]
            push!(arbre, edge1)
            for edge2 in SC[comp[1]].nodenames
                push!(SC[comp[2]].nodenames, edge2)
            end
            deleteat!(SC, comp[1])
        end
    end
    arbre
end

#Construction du graphe présent dans les notes de cours.
Gexcours = Graph("Gtest", [Node("a", [0, 0]),
Node("b", [0, 0]),
Node("c", [0, 0]),
Node("d", [0, 0]),
Node("e", [0, 0]),
Node("f", [0, 0]),
Node("g", [0, 0]),
Node("h", [0, 0]),
Node("i", [0, 0])],
[Edge("a↔b", ("a", "b"), 4),
Edge("b↔c", ("b", "c"), 8),
Edge("c↔d", ("c", "d"), 7),
Edge("d↔e", ("d", "e"), 9),
Edge("e↔f", ("e", "f"), 10),
Edge("f↔g", ("f", "g"), 2),
Edge("a↔h", ("a", "h"), 8),
Edge("i↔h", ("i", "h"), 7),
Edge("b↔h", ("b", "h"), 11),
Edge("g↔i", ("g", "i"), 6),
Edge("f↔d", ("f", "d"), 14),
Edge("c↔f", ("c", "f"), 4),
Edge("g↔h", ("g", "h"), 1),
Edge("c↔i", ("c", "i"), 2)])

"""
Calcule la somme des coûts des arêtes dans un arbre.
"""
function sommeweights(arbre)
    somme = 0
    for e in arbre
        somme += e.weight
    end
    somme
end

"""
Teste la fonction kruskal() sur tous les fichiers .tsp.
"""
function test_kruskal(path)
	for file_name in readdir(path)
		if file_name[end-3:end] == ".tsp"

			G = createGraph(string(file_name), string(path, "/", file_name))
            arbrecoutmin = kruskal(G)
            @test length(arbrecoutmin) == nb_nodes(G) - 1
            println(file_name, " ✓")

        end
    end
end

#Les lignes qui suivent sont exécutées en démonstration dans le fichier Pluto.

#arbrecoutmin = kruskal(Gexcours)
#for e in arbrecoutmin
#    println(e)
#end
#@test length(arbrecoutmin) == nb_nodes(Gexcours) - 1
#@test sommeweights(arbrecoutmin) == 37
#println("G exemple du cours ✓")

#test_kruskal("mth6412b-starter-code/instances/stsp")