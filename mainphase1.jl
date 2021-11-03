using Plots
using Test

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
	edge_weight_format = dict["EDGE_WEIGHT_FORMAT"]
		
	G = Graph(graphname, Node{Vector{Float64}}[], Edge{Vector{Float64}, Float64}[])

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
		for node1 in nodes(G)
			if parse(Int64, name(node1)) == edge_list[i][1]
				for node2 in nodes(G)
					if parse(Int64, name(node2)) == edge_list[i][2]
						newedge = Edge(string(edge_list[i][1], "↔", edge_list[i][2]), (node1, node2) , weight_list[i])
	
						if edge_weight_format == "FULL_MATRIX"
							add_edge!(G, newedge)
						elseif edge_weight_format != "FULL_MATRIX"
							add_edge!(G, newedge)
						end
					end
				end
			end
		end
	end
	G
end

"""
Teste la création d'un graphe G pour chaque fichier .tsp.
"""
function test_creation_graphe(path)
	for file_name in readdir(path)
		if file_name[end-3:end] == ".tsp"  #&& file_name != "pa561.tsp"
			G = createGraph(string(file_name), string(path, "/", file_name))
			for i in 1:nb_edges(G)
				@test !isinedges(edges(G)[[1:i-1; i+1:nb_edges(G)]], edges(G)[i])
			end
			@test Float64(nb_edges(G)) == (nb_nodes(G)*(nb_nodes(G)-1))/2
			println(file_name, " ✓")
			
			#Les lignes qui suivent innondent le REPL, à décommenter à vos risques
			#show(G)
			#plot_graph(string(path, "/", file_name))
		end
	end
end

#La ligne qui suit est exécutée en démonstration dans le fichier Pluto.
#test_creation_graphe("mth6412b-starter-code/instances/stsp")