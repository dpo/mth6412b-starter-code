using Test

include("projet/phase1/edge.jl")
include("projet/phase1/node.jl")
include("projet/phase1/graph.jl")
include("projet/phase1/read_stsp.jl")

dict_bays29 = read_header("mth6412b-starter-code/instances/stsp/bays29.tsp")
@test typeof(dict_bays29) <: Dict

edge_list, weight_list = read_edges(dict_bays29, "mth6412b-starter-code/instances/stsp/bays29.tsp")
@test length(edge_list)==length(weight_list)

node_list = read_nodes(dict_bays29, "mth6412b-starter-code/instances/stsp/bays29.tsp")
display(node_list)