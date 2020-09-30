# using Pkg
# Pkg.activate(joinpath(@__DIR__, "mth6412b/"))
import Base.show
using Plots
include(joinpath(@__DIR__, "exceptions.jl"))
include(joinpath(@__DIR__, "node.jl"))
include(joinpath(@__DIR__, "edge.jl"))
include(joinpath(@__DIR__, "graph.jl"))
include(joinpath(@__DIR__, "connected_component.jl"))

# filename = joinpath(@__DIR__, "..\\..\\instances\\stsp\\gr17.tsp")

# graph = build_graph(filename)
lab_nodes = [Node("a",1),Node("b",2),Node("c",3),Node("d",4),Node("e",5),Node("f",6),Node("g",7),Node("h",8),Node("i",9)]
lab_edges = [Edge(("a","b"),4),Edge(("a","h"),8),Edge(("b","c"),8),Edge(("b","h"),11),Edge(("c","d"),7),Edge(("c","f"),4),Edge(("c","i"),2),Edge(("d","e"),9),Edge(("d","f"),14),Edge(("e","f"),10),Edge(("f","g"),2),Edge(("g","h"),1),Edge(("g","i"),6),Edge(("h","i"),7)]
graph = Graph("laboratory graph", lab_nodes, lab_edges)
show(graph)

show(kruskal(graph))
