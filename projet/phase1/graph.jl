import Base.show

"""Type abstrait dont d'autres types de graphes dériveront."""
abstract type AbstractGraph{T} end

"""Type representant un graphe comme un ensemble de noeuds.

Exemple :

    node1 = Node("Joe", 3.14)
    node2 = Node("Steve", exp(1))
    node3 = Node("Jill", 4.12)
    G = Graph("Ick", [node1, node2, node3])

Attention, tous les noeuds doivent avoir des données de même type.
"""
mutable struct Graph{T} <: AbstractGraph{T}
  name::String
  nodes::Vector{Node{T}}
  edges::Vector{Edge{T}}
end

"""Adds a node to the graph."""
function add_node!(graph::Graph{T}, node::Node{T}) where T
  push!(graph.nodes, node)
  graph
end

"""Adds an edge to the graph."""
function add_edge!(graph::Graph{T} where T, edge::Edge{S} where S) 
  push!(graph.edges, edge)
  graph
end


# we assume that all graphs deriving from AbstractGraph
# will have fields `name` and `nodes`.

"""Returns the name of the graph."""
name(graph::AbstractGraph) = graph.name

"""Returns the list of nodes of the graph."""
nodes(graph::AbstractGraph) = graph.nodes

"""Returns the number of nodes in the graph."""
nb_nodes(graph::AbstractGraph) = length(graph.nodes)

"""Returns the list of edges of the graph."""
edges(graph::AbstractGraph) = graph.edges

"""Display a graph"""
function show(graph::Graph)
  println("Graph ", name(graph), " has ", nb_nodes(graph), " nodes.")
  for node in nodes(graph)
    show(node)
  end
  for edge in edges(graph)
    show(edge)
  end
end
