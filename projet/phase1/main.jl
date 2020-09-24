import Base.show
using Plots
include(joinpath(@__DIR__, "node.jl"))
include(joinpath(@__DIR__, "edge.jl"))
include(joinpath(@__DIR__, "graph.jl"))

filename = joinpath(@__DIR__, "..\\..\\instances\\stsp\\gr21.tsp")
graph = build_graph(filename)
show(graph)

plot_graph(filename)


 ## Some code to test add edges function
#=  println("fff")
 n1= Node("first",1)
 n2= Node("second",2)
 n3= Node("third",3)
 edg1= Edge((n1.name,n2.name),1.2)
 edg2= Edge((n1.name,n3.name),1.8)
 g= Graph("deb", [n1,n2,n3],[edg1,edg2])
show(g)
add_edge!(g, Edge((n1.name, Node("d",3).name), 10.1))
add_edge!(g, Edge((n2.name, n3.name), 10.1))
add_edge!(g, Edge((n2.name, n1.name), 10.1))
show(g) =#
