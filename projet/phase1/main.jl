import Base.show
using Plots
include(joinpath(@__DIR__, "node.jl"))
include(joinpath(@__DIR__, "edge.jl"))
include(joinpath(@__DIR__, "graph.jl"))

filename = joinpath(@__DIR__, "..\\..\\instances\\stsp\\bayg29.tsp")
graph = build_graph(filename)
show(graph)

plot_graph(filename)

 ## Some code to test add edges function
 #= println("fff")
 n1= Node("first",1)
 n2= Node("second",2)
 n3= Node("third",3)
println(n1==n1)
 edg1= Edge((n1,n2),1.2)
 edg2= Edge((n1,n3),1.8)L
 g= Graph("deb", [n1,n2,n3],[edg1,edg2])
show(g)
add_edge!(g, Edge((n1, Node("d",3)), 10.1))
add_edge!(g, Edge((n2, n3), 10.1))
add_edge!(g, Edge((n2, n1), 10.1))
show(g) =#
