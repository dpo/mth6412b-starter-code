import Base.show
using Plots
include(joinpath(@__DIR__, "node.jl"))
include(joinpath(@__DIR__, "edge.jl"))
include(joinpath(@__DIR__, "graph.jl"))

filename = joinpath(@__DIR__, "..\\..\\instances\\stsp\\gr17.tsp")

graph = build_graph(filename)
show(graph)
# plot_graph(filename)
plot_graph(graph)

