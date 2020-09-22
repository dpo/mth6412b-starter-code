import Base.show
using Plots
include(joinpath(@__DIR__, "node.jl"))
include(joinpath(@__DIR__, "edge.jl"))
include(joinpath(@__DIR__, "graph.jl"))
include(joinpath(@__DIR__, "read_stsp.jl"))

filename = joinpath(@__DIR__, "..\\..\\instances\\stsp\\bayg29.tsp")
header = read_header(filename)

node_dict = read_nodes(header, filename)

edge_weight_format = header["EDGE_WEIGHT_FORMAT"]
k = 10
dim = parse(Int, header["DIMENSION"])
n_to_read = n_nodes_to_read(edge_weight_format, k, dim)

edge_dict = read_edges(header, filename)


# add_node!(graph, Node("Corentin", 3))
# add_edge!(graph, Edge((node2, node1), 10.1))
# # TODO: make it possible to have edges of a different type than the graph