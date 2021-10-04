using Plots

include("projet/phase1/node.jl")
include("projet/phase1/edge.jl")
include("projet/phase1/graph.jl")
include("projet/phase1/read_stsp.jl")

"""Renvoie true si l'edge existe déjà (dans le même sens ou dans le sens inverse) dans la liste de edges."""
function isinedges(edges, edge)
	for e in edges
		if (e.data[1] == edge.data[2] && e.data[2] == edge.data[1]) ||
			(e.data[1] == edge.data[1] && e.data[2] == edge.data[2])
			return true
		end
	end
	return false
end

"""
Renvoie un objet de type Graphe à partir d'un fichier .tsp.
"""
function createGraph(graphname::String, filename::String)
	
	dict = read_header(filename)
	edge_list, weight_list = read_edges(dict, filename)
	node_list = read_nodes(dict, filename)
	edge_weight_format = dict["EDGE_WEIGHT_FORMAT"]
		
	G = Graph(graphname, Node{Vector{Float64}}[], Edge{Vector{Float64}, Int64}[])

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
		for node1 in G.nodes
			if parse(Int64, node1.name) == edge_list[i][1]
				for node2 in G.nodes
					if parse(Int64, node2.name) == edge_list[i][2]
						newedge = Edge(string(edge_list[i][1], "↔", edge_list[i][2]), (node1, node2) , weight_list[i])
	
						if edge_weight_format == "FULL_MATRIX" && !isinedges(G.edges, newedge)
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
		if file_name[end-3:end] == ".tsp"
			G = createGraph(string(file_name), string(path, "/", file_name))
			for i in 1:length(G.edges)
				@test !isinedges(G.edges[[1:i-1; i+1:length(G.edges)]], G.edges[i])
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