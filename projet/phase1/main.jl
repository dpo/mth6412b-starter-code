import Base.show
include(joinpath(@__DIR__, "node.jl"))
include(joinpath(@__DIR__, "graph.jl"))

graph = Graph("test", [Node("jean", 1)])

