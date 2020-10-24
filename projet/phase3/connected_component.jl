""" abstract type for connected components of a graph """
abstract type AbstractConnectedComponent{T,P} <: AbstractGraph{T,P} end

""" Datatype for a connected component of a graph

    Used for the implementation of Kruskal. One can think 
        of this datatype as the representation of a sub-graph

    Ex: c1 = ConnectedComponent("a", [Node("a",12), Node("b", π)], [Edge(("a","b"), e)])

"""
mutable struct ConnectedComponent{T,P} <: AbstractConnectedComponent{T,P}
    root::String
    nodes::Vector{Node{T}}
    edges::Vector{Edge{P}} 
end

root(connected_component::AbstractConnectedComponent) = connected_component.root

"""prints a ConnectedComponent"""
function show(MST::ConnectedComponent, graph::Graph)
  println("MST of the graph ", name(graph), " has ", length(nodes(MST)), " nodes.")
  for node in nodes(MST)
    show(node)
  end
  for edge in edges(MST)
    show(edge)
  end
end