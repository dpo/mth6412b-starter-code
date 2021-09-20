import Base.show

"""Type abstrait dont d'autres types de graphes dériveront."""
abstract type AbstractGraph{T, I} end

"""Type representant un graphe comme un ensemble de noeuds.

Exemple :

    node1 = Node("Joe", 3.14)
    node2 = Node("Steve", exp(1))
    node3 = Node("Jill", 4.12)
    edge1 = Edge("Mtl_Qc", (1.0, 2.0), 20.0)
    G = Graph("Ick", [node1, node2, node3], [edge1])

Attention, tous les noeuds doivent avoir des données de même type.
"""
mutable struct Graph{T, I} <: AbstractGraph{T, I}
  name::String
  nodes::Vector{Node{T}}
  edges::Vector{Edge{I}}
end

"""Ajoute un noeud au graphe."""
function add_node!(graph::Graph, node::Node)
  push!(graph.nodes, node)
  graph
end

"""Ajoute une arète au graphe."""
function add_edge!(graph::Graph, edge::Edge)
  push!(graph.edges, edge)
  graph
end

# on présume que tous les graphes dérivant d'AbstractGraph
# posséderont des champs `name`, `edges` et `nodes`.

"""Renvoie le nom du graphe."""
name(graph::AbstractGraph) = graph.name

"""Renvoie la liste des noeuds du graphe."""
nodes(graph::AbstractGraph) = graph.nodes

"""Renvoie la liste des arètes du graphe."""
edges(graph::AbstractGraph) = graph.edges

"""Renvoie le nombre de noeuds du graphe."""
nb_nodes(graph::AbstractGraph) = length(graph.nodes)

"""Renvoie le nombre d'arètes du graphe."""
nb_edges(graph::AbstractGraph) = length(graph.edges)

"""Affiche un graphe"""
function show(graph::Graph)
  println("Graph ", name(graph), " has ", nb_nodes(graph), " nodes and ", nb_edges(graph), " edges.")
  for node in nodes(graph)
    show(node)
  end
  for edge in edges(graph)
    show(edge)
  end
end
