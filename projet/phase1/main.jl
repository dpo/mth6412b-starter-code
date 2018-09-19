### On a ajoute les structures/fonctions nécessaires
include("node.jl")
include("edge.jl")
include("graph.jl")
include("read_stsp.jl")

### Notre fichier test. On aurait pu prendre n'importe quel fichier tsp
### dans instances/stsp/ puisqu'il s'agit uniquement de problème symétrique
### On va chercher les problèmes qui ont des sommets et des arêtes.
### Le fichier brazil58.tsp par exemple n'a pas de sommet mais présente des
### arêtes ce qui ne fait pas de sens, car notre classe Edge a besoin de sommets
### a relié
file = "../../instances/stsp/bayg29.tsp"
# file = "../../instances/stsp/bays29.tsp"
# file = "../../instances/stsp/dantzig42.tsp"
# file = "../../instances/stsp/gr120.tsp"
# file = "../../instances/stsp/pa561.tsp"


### On va chercher l'information utilisable des fichiers tsp grace à la fonction
### read_stsp. On va ensuite convertir cette information pour quelle soit utilisable
### par la classe graphe
nodes_init, edges_init = read_stsp(file)
#
# ### Pour se simplifier la vie on met les sommet en ordre croissant
nodes_init = sort(nodes_init)

### Les sommets et arêtes que l'on va utiliser pour créer le graphe
nodes_graph = Array{Node{Array{Float64,1}}, 1}()
edges_graph = Array{Edge, 1}()

### On met tout les sommes dans un tableau de sommets"""
for node in nodes_init
    push!(nodes_graph, Node(string(node[1]), node[2]))
end

### On ajoute les arêtes à notre graphe
### On a deux types de structures de matrices avec les poids:
### 1) Des matrices tels qu'à la ligne i on a les poids des arêtes reliant
###    le sommet i au sommet j. Dans ce cas il faut utiliser le premier if
###    pour créer des arêtes.
### 2) Sinon on a une structure plus simple: la composante (i,j) de edges_init
###    représente l'arête reliant les sommets i et j. Dans un tel cas, on a
###    qu'à parcourir tout les éléments de la matrice. On utilise le second if.
for i = 1:length(edges_init)
    edge = edges_init[i]
    if edges_init[i][1][1] > 1
        for j = i:length(edges_init)
            push!(edges_graph, Edge(nodes_graph[i], nodes_graph[j+1], edge[j-i+1][2]))
        end
    elseif edges_init[i][1][1] == 1
        for j = 1:length(edges_init[i])
            push!(edges_graph, Edge(nodes_graph[i], nodes_graph[j], edge[j][2]))
        end
    end
end


G = Graph("[insert graph name here]", nodes_graph, edges_graph);
show(G)
