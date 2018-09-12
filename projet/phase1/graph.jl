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

"""Ajoute un noeud au graphe."""
function add_node!(graph::Graph{T}, node::Node{T}) where T
	push!(graph.nodes, node)
	graph
end

function add_edge!(graph::Graph{T}, edge::Edge{T}) where T
	push!(graph.edges, edge)
	graph
end

# on présume que tous les graphes dérivant d'AbstractGraph
# posséderont des champs `name` et `nodes`.

"""Renvoie le nom du graphe."""
name(graph::AbstractGraph) = graph.name

"""Renvoie la liste des noeuds du graphe."""
nodes(graph::AbstractGraph) = graph.nodes

"""Renvoie le nombre de noeuds du graphe."""
nb_nodes(graph::AbstractGraph) = length(graph.nodes)

"""Renvoie la liste des arretes du graphe."""
graph_edges(graph::AbstractGraph) = graph.edges

"""Renvoie le nombre de arretes du graphe."""
nb_edges(graph::AbstractGraph) = length(graph.edges)

"""Affiche un graphe"""
function show(graph::Graph)
	name = name(graph)
	nb_nodes = nb_nodes(graph)
	nb_edges = nd_edges()
	s = string("Graph ", name, " has ", nb_nodes, " nodes")
	for node in nodes(graph)
		s = string(s, "\n", show(node))
	end
	s = string(s, "\n", "and ", nb_edges, " edges")
	for edge in graph_edges(graph)
		s = string(s, "\n", show(edge))
	end
	println(s)
end
