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
  edges::Vector{Edge}
end

"""Ajoute un noeud au graphe."""
function add_node!(graph::Graph{T}, node::Node{T}) where T
  push!(graph.nodes, node)
  graph
end

"""Ajoute une arete au graphe. """
function add_edge!(graph::Graph, edge:: Edge) 
  if poids(edge) != 0
    push!(graph.edges, edge)
  end
  graph
end

function find_nodes(nodes::Vector{Node{T}},edge ::Edge) where T
  sommet1, sommet2 = sommets(edge)
  lis_noeuds = Node{T}[]
  for node in nodes
    if node.name == sommet1 || node.name == sommet2
      push!(lis_noeuds, node)
    end
  end

  if lis_noeuds[1].name == sommet2
    return [lis_noeuds[2], lis_noeuds[1]]
  else
    return lis_noeuds
  end

end
# on présume que tous les graphes dérivant d'AbstractGraph
# posséderont des champs `name` et `nodes`.

"""Renvoie le nom du graphe."""
name(graph::AbstractGraph) = graph.name

"""Renvoie la liste des noeuds du graphe."""
nodes(graph::AbstractGraph) = graph.nodes

""" Renvoie la liste des aretes du graphe. """
edges(graph::AbstractGraph) = graph.edges

"""Renvoie le nombre de noeuds du graphe."""
nb_nodes(graph::AbstractGraph) = length(graph.nodes)

""" Renvoie le nombre d'arêtes du graphe. """
nb_edges(graph::AbstractGraph) = length(graph.edges)

"""Affiche un graphe"""
function show(graph::Graph)
  println("Graph ", name(graph), " has ", nb_nodes(graph), " nodes.")
  for node in nodes(graph)
    show(node)
  end


  println("Graph ", name(graph), " has ", nb_edges(graph), " edges.")
  for edge in edges(graph)
    show(edge)
  end
end
