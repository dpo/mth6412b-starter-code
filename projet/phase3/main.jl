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
include(joinpath(@__DIR__, "heuristics.jl"))
include(joinpath(@__DIR__, "kruskal.jl"))
include(joinpath(@__DIR__, "prim.jl"))

filename = joinpath(@__DIR__, "..\\..\\instances\\stsp\\bays29.tsp")

graph = build_graph(filename)

mst_kruskal, kruskal_weight = kruskal(graph)

mst_prim, prim_weight = prim(graph)

println("kruskal_weight: ", kruskal_weight, " prim_weight: ", prim_weight)

plot_graph(mst_kruskal)

plot_graph(mst_prim)