include("mainphase1.jl")
include("projet/phase2/connexcomp.jl")

"""
Applique l'algorithme de Kruskal sur un graphe. Renvoie l'arbre de coût minimum recouvrant le graphe.
"""
function kruskal(graph::Graph{T, I}) where{T, I}
    # Trier les arêtes du graphe en ordre croissant de poids.
    sort!(graph.edges)

    #Initialisation de l'arbre de coût minimum
    #et de SC le vecteur des S, où S est une composante connexe de G.
    arbre = Vector{Union{Nothing, Edge{T, I}}}(nothing, nb_nodes(graph) - 1)
    j = 0
    SC = [ConnexComp(Node{T}[node]) for node in nodes(graph)]

    comp = [0, 0]
    for edge in edges(graph)
        si = edge.data[1]
        sj = edge.data[2]
        comp .= 0
        for i in 1:length(SC)
            #Pour chaque arête [si, sj], on place l'indice par rapport à SC de la composante connexe contenant 
            #si et l'indice de sj dans la liste comp.
            for s in nodes(SC[i])
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
            j += 1
            arbre[j] = edge
            for node in nodes(SC[comp[1]])
                push!(nodes(SC[comp[2]]), node)
            end
            deleteat!(SC, comp[1])
        end
    end
    arbre
end

#Construction du graphe présent dans les notes de cours.
a = Node("a", [0, 0])
b = Node("b", [0, 0])
c = Node("c", [0, 0])
d = Node("d", [0, 0])
e = Node("e", [0, 0])
f = Node("f", [0, 0])
g = Node("g", [0, 0])
h = Node("h", [0, 0])
i = Node("i", [0, 0])

Gexcours = Graph("Gtest", [a, b, c, d, e, f, g, h, i],
[Edge("a↔b", (a, b), 4),
Edge("b↔c", (b, c), 8),
Edge("c↔d", (c, d), 7),
Edge("d↔e", (d, e), 9),
Edge("e↔f", (e, f), 10),
Edge("f↔g", (f, g), 2),
Edge("a↔h", (a, h), 8),
Edge("i↔h", (i, h), 7),
Edge("b↔h", (b, h), 11),
Edge("g↔i", (g, i), 6),
Edge("f↔d", (f, d), 14),
Edge("c↔f", (c, f), 4),
Edge("g↔h", (g, h), 1),
Edge("c↔i", (c, i), 2)])

"""
Calcule la somme des coûts des arêtes dans un arbre.
"""
function sommeweights(arbre::Vector{Union{Nothing, Edge{T, I}}}) where {T, I}
    somme = 0
    for e in arbre
        somme += weight(e)
    end
    somme
end

"""
Teste la fonction une implémentation de kruskal sur tous les fichiers .tsp.
"""
function test_kruskal(path, kruskal_func)
	for file_name in readdir(path)
		if file_name[end-3:end] == ".tsp"  #&& file_name != "pa561.tsp"

			G = createGraph(string(file_name), string(path, "/", file_name))
            arbrecoutmin = kruskal_func(G)
            @test nothing ∉ arbrecoutmin
            println(file_name, " ✓\tavec cout total: ", sommeweights(arbrecoutmin))
        end
    end
end

#Les lignes qui suivent sont exécutées en démonstration dans le fichier Pluto.

#arbrecoutmin = kruskal(Gexcours)
#for e in arbrecoutmin
#    show(e)
#end
#@test nothing ∉ arbrecoutmin
#@test sommeweights(arbrecoutmin) == 37
#println("G exemple du cours ✓")

#test_kruskal("mth6412b-starter-code/instances/stsp", kruskal)