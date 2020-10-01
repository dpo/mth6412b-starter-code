# using Pkg
# Pkg.activate(joinpath(@__DIR__, "mth6412b/"))
using Test
import Base.show
using Plots
include(joinpath(@__DIR__, "exceptions.jl"))
include(joinpath(@__DIR__, "node.jl"))
include(joinpath(@__DIR__, "edge.jl"))
include(joinpath(@__DIR__, "graph.jl"))
include(joinpath(@__DIR__, "connected_component.jl"))

filename = joinpath(@__DIR__, "..\\..\\instances\\stsp\\bays29.tsp")

graph = build_graph(filename)

# show(graph)
mst = kruskal(graph)
show(mst, graph)
plot_graph(mst)

include("D:\\tmons\\Documents\\Poly\\5_A20\\MTH6412B\\mth6412b-starter-code\\projet\\tests\\test_kruskal.jl")
