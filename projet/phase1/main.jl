include("node.jl")
include("edge.jl")
include("graph.jl")
include("read_stsp.jl")

filename = "/Users/jules/Desktop/MTH6412B/Git/mth6412b-starter-code/instances/stsp/bays29.tsp"
function build_graph(filename::String)
    graph_nodes, graph_edges, weights = read_stsp(filename)
    
    Graphe = Graph("NomDeVotreGraphe", Vector{Node{Vector{Float64}}}([]), Vector{Edge{Vector{Float64}}}([]))

    # ajouter tous les noeuds 
    for i = 1:length(graph_nodes)
        noeud = Node(string(i), graph_nodes[i])  
        add_node!(Graphe,noeud)
    end

    # ajouter toutes les arêtes
    for i = 1:length(graph_edges)
        for j = 1:length(graph_edges[i])
            noeud_depart = Node(string(i), graph_nodes[i]) 
            noeud_arrivee = Node(string(graph_edges[i][j]), graph_nodes[graph_edges[i][j]]) #le noeud i est lié à tous les noeuds de numéro graph_edges[i][j]
            weight = weights[i][graph_edges[i][j]]
            arete = Edge(noeud_depart,noeud_arrivee,weight)
            add_edge!(Graphe,arete)
        end
    end
    return Graphe
end

Graphe_test = build_graph(filename)