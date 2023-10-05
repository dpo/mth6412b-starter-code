include("node.jl")
include("edge.jl")
include("graph.jl")
include("read_stsp.jl")

filename = "/Users/jules/Desktop/MTH6412B/Git/mth6412b-starter-code/instances/stsp/bays29.tsp"
function build_graph(filename::String)
    graph_nodes, graph_edges = read_stsp(filename)
    
    Graphe_test = Graph{Float64}("Test", Node[], Edge[])  
    for i = 1:length(graph_nodes)
        noeud = Node(string(i), graph_nodes[i])  
        Graphe_test.add_node!(noeud)
    end

    for j = 1:length(graph_edges)
        origine = graph_edges[j][1]
        destination = graph_edges[j][2]
        poids = graph_edges[j][3]
        origine_node = Graphe_test.nodes[origine]
        destination_node = Graphe_test.nodes[destination]
        arete = Edge(origine_node, destination_node, poids) 
        Graphe_test.add_edge!(arete)
    end

    return Graphe_test
end