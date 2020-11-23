import Base.show

include("node.jl")
include("edge.jl")

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

"""Ajoute un noeud au graphe."""
function add_node!(graph::Graph{T}, node::Node{T}) where T
  push!(graph.nodes, node)
  graph
end

"""
  add_edge!(g, e)

Add edge `e` to graph `g`.
"""
add_edge!(g::Graph{T}, e::Edge{T}) where{T} = push!(g.edges, e)

# on présume que tous les graphes dérivant d'AbstractGraph
# posséderont des champs `name` et `nodes`.

"""Renvoie le nom du graphe."""
name(graph::Graph) = graph.name

"""Renvoie la liste des noeuds du graphe."""
nodes(graph::Graph) = graph.nodes

"""Renvoie la liste des aretes du graphe."""
edges(graph::Graph) = graph.edges

"""Renvoie le nombre de noeuds du graphe."""
nb_nodes(graph::Graph) = length(graph.nodes)

"""Renvioe le nombre d'aretes du graphe."""
nb_edges(g::Graph) = length(g.edges)

"""Affiche un graphe"""
function show(graph::Graph)
  println("Graph ", name(graph), " has ", nb_nodes(graph), " nodes and ", nb_edges(graph), " edges.")
  for node in nodes(graph)
    show(node)
  end
  for e in graph.edges
    show(e)
  end
end
