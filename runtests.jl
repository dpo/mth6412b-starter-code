using Test

include("projet/phase1/edge.jl")
include("projet/phase1/node.jl")
include("projet/phase1/graph.jl")
include("projet/phase1/read_stsp.jl")

"""
Renvoie un objet de type Graphe à partir d'un fichier .tsp
"""
function createGraph(graphname::String, filename::String)
	
	dict = read_header(filename)
	edge_list, weight_list = read_edges(dict, filename)
	node_list = read_nodes(dict, filename)
		
	G = Graph(graphname, Node{Vector{Float64}}[], Edge{Int64}[])

	for no in node_list
		newnode = Node(string(no[1]), no[2])
		add_node!(G, newnode)
	end
	
	for i in 1:length(edge_list)
		newedge = Edge(string(edge_list[i][1], "↔", edge_list[i][2]), edge_list[i], weight_list[i])
		add_edge!(G, newedge)
	end
	G
end

G = createGraph("bays29", raw"mth6412b-starter-code/instances/stsp/bays29.tsp")
show(G)

plot_graph(raw"mth6412b-starter-code/instances/stsp/bays29.tsp")