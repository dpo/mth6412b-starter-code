import Base.show
include(joinpath(@__DIR__, "node.jl"))
include(joinpath(@__DIR__, "edge.jl"))
include(joinpath(@__DIR__, "graph.jl"))

node1 = Node("jean", 1)
node2 = Node("kevin", 2)
graph = Graph("test", [node1, node2], [Edge((node1, node2), 10)])

show(graph)

# TODO: make it possible to have edges of a different type than the graph