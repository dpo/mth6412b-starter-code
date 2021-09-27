using Plots

include("projet/phase1/node.jl")
include("projet/phase1/edge.jl")
include("projet/phase1/graph.jl")
include("projet/phase1/read_stsp.jl")

"""
Renvoie un objet de type Graphe à partir d'un fichier .tsp.
"""
function createGraph(graphname::String, filename::String)
	
	dict = read_header(filename)
	edge_list, weight_list = read_edges(dict, filename)
	node_list = read_nodes(dict, filename)
		
	G = Graph(graphname, Node{Vector{Float64}}[], Edge{Int64, Int64}[])

	if length(node_list) == 0
		dim = parse(Int, dict["DIMENSION"])
		for s in 1:dim
			newnode = Node(string(s), Float64[])
			add_node!(G, newnode)
		end
	else
		for no in node_list
			newnode = Node(string(no[1]), no[2])
			add_node!(G, newnode)
		end
	end

	for i in 1:length(edge_list)
		newedge = Edge(string(edge_list[i][1], "↔", edge_list[i][2]), edge_list[i], weight_list[i])
		add_edge!(G, newedge)
	end
	G
end

"""
Crée un graphe G pour chaque fichier .tsp.
"""
function test_creation_graphe(path)
	for file_name in readdir(path)
		if file_name[end-3:end] == ".tsp"
			G = createGraph(string(file_name), string(path, "/", file_name))
			println(file_name, " ✓")
			#Les lignes qui suivent innondent le REPL, à décommenter à vos risques
			#show(G)
			#plot_graph(string(path, "/", file_name))
		end
	end
end

#La ligne qui suit est exécutée en démonstration dans le fichier Pluto.
#test_creation_graphe("mth6412b-starter-code/instances/stsp")