# Abdou Main

include("edge.jl")
using .edge
include("graph.jl")
using .graph
include("node.jl")
using .node
include("read_stsp.jl")
using .read_stsp

n1=Node("Quebec",418)
n2=Node("Montreal",515)

v= Edge(n1,n2,949)

println("il y a quoi")