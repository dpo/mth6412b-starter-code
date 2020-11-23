include("node.jl")
include("edge.jl")
include("graph.jl")
include("read_stsp.jl")

# Tests of read_stsp.jl
wd_stsp = "../instances/stsp/"
instances_stsp = ["bayg29.tsp", "bays29.tsp", "brazil58.tsp", "brg180.tsp",
				  "dantzig42.tsp", "fri26.tsp", "gr17.tsp", "gr21.tsp", "swiss42.tsp",
				  "gr24.tsp", "gr48.tsp", "gr120.tsp", "hk48.tsp", "pa561.tsp"]

for instance in instances_stsp
	println()
	nom_fichier = string(wd_stsp, instance)
	println(nom_fichier)

	header = read_header(nom_fichier)
	local nodes = read_nodes(header, nom_fichier)
	local edges = read_edges(header, nom_fichier)
	noeuds, aretes = read_stsp(nom_fichier)
end
