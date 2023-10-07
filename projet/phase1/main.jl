include("node.jl")
include("edge.jl")
include("graph.jl")
include("read_stsp.jl")

filename = "/Users/jules/Desktop/MTH6412B/Git/mth6412b-starter-code/instances/stsp/bays29.tsp"
function build_graph(filename::String, graph_name::String)
    graph_nodes, graph_edges, weights = read_stsp(filename)
    
    # On crée un graphe vide : composé d'un nom, d'un vecteur de noeuds (les noeuds sont des vecteurs de Float64 qui représentent les coordonnées dans l'espace du noeud (x,y), et d'un vecteur d'arête)
    Graphe = Graph(graph_name, Vector{Node{Vector{Float64}}}([]), Vector{Edge{Vector{Float64}}}([]))

    # Ajouter tous les noeuds 
    for i = 1:length(graph_nodes)
        noeud = Node(string(i), graph_nodes[i])  #graph_nodes est un dictionnaire : graph_nodes[i] renvoit le vecteur [x,y] du noeud i
        add_node!(Graphe,noeud)
    end

    # ajouter toutes les arêtes
    for i = 1:length(graph_edges)
        for j = 1:length(graph_edges[i])
            noeud_depart = Node(string(i), graph_nodes[i]) 
            noeud_arrivee = Node(string(graph_edges[i][j]), graph_nodes[graph_edges[i][j]]) #graph_edges[i][j] = Int64 est le j-eme noeud auquel le noeud i est lié => on cherche dans le dictionnaire graphe_nodes le noeud numero graph_edges[i][j]
            weight = weights[i][graph_edges[i][j]] # on cherche donc le poids associée à l'arête reliant le noeud "i" et le noeud "graph_edges[i][j]"
            arete = Edge(noeud_depart,noeud_arrivee,weight) # on construit l'arête
            add_edge!(Graphe,arete) # on l'ajoute au graphe
        end
    end
    return Graphe
end

#Graphe_test = build_graph(filename,"Graphe_test")