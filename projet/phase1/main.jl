### On a ajoute les structures/fonctions nécessaires
include("node.jl")
include("edge.jl")
include("graph.jl")
include("read_stsp.jl")

### Notre fichier test. On aurait pu prendre n'importe quel fichier tsp
### dans instances/stsp/ puisqu'il s'agit uniquement de problème symétrique
file = "../../instances/stsp/bayg29.tsp"
# file = "../../instances/stsp/bays29.tsp"
# file = "../../instances/stsp/dantzig42.tsp"


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
for i = 1:length(edges_init)
    for j = 1:length(edges_init[i])
        edge = edges_init[i]
        push!(edges_graph, Edge(nodes_graph[i], nodes_graph[j], edge[j][2]))
    end
end


G = Graph("[insert graph name here]", nodes_graph, edges_graph);
show(G)
