import Base.show
using Plots

"""Type abstrait dont d'autres types de graphes dériveront."""
abstract type AbstractGraph{T, I} end

"""Type representant un graphe comme un ensemble de noeuds.

Exemple :

  node1 = Node("Montreal", 24.12)
  node2 = Node("Quebec", 4.12)
  edge1 = Edge("Mtl_Qc", (node1, node2), 20.0)
  G = Graph("Ick", [node1, node2], [edge1])

Attention, tous les noeuds doivent avoir des données de même type.
"""
mutable struct Graph{T, I} <: AbstractGraph{T, I}
  name::String
  nodes::Vector{Node{T}}
  edges::Vector{Edge{T, I}}
end


"""Renvoie true si l'edge existe déjà (dans le même sens ou dans le sens inverse) dans la liste de edges."""
function isinedges(edges, edge)
	for e in edges
		if (data(e)[1] == data(edge)[2] && data(e)[2] == data(edge)[1]) ||
		   (data(e)[1] == data(edge)[1] && data(e)[2] == data(edge)[2])
			return true
		end
	end
	return false
end

"""Ajoute un noeud au graphe."""
function add_node!(graph::Graph{T}, node::Node{T}) where T
  if node ∉ nodes(graph)
    push!(graph.nodes, node)
  end
  graph
end

"""Ajoute une arète au graphe."""
function add_edge!(graph::Graph{T, I}, edge::Edge{T, I}) where {T, I}
  if !isinedges(edges(graph), edge)
    push!(graph.edges, edge)
  end
  graph
end

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

"""
Calcule la somme des coûts sur les sommets d'un graph.
"""
function sommeweights(graph::Graph{T, I}) where {T, I}
    somme = 0
    for node in nodes(graph)
        somme += min_weight(node)
    end
    somme
end

"""Affiche un graphe étant données un ensemble de noeuds et d'arêtes."""
function plot_graph2(nodes, edges)
  fig = plot(legend=false)

  # edge positions
  for edge in edges
    plot!([coordinates(data(edge)[1])[1], coordinates(data(edge)[2])[1]],
          [coordinates(data(edge)[1])[2], coordinates(data(edge)[2])[2]],
          linewidth=1.5, alpha=0.75, color=:lightgray)
  end

  # node positions
  xys = [coordinates(node) for node in nodes]
  x = [xy[1] for xy in xys]
  y = [xy[2] for xy in xys]
  scatter!(x, y)

  fig
end