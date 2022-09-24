import Base.show

"""Type abstrait dont d'autres types d'arêtes dériveront."""
abstract type AbstractEdge{T} end

"""Type représentant les arêtes d'un graphe.

Exemple:

        arete = Edge((Node,Node), 354)
        
"""
mutable struct Edge{T} <: AbstractEdge{T}
  node_i::Node
  node_j::Node
  weight::Float64
end

"""Renvoie les extrémités d'une arête."""
node_i(edge::AbstractEdge) = edge.node_i
node_j(edge::AbstractEdge) = edge.node_j

"""Renvoie le poids d'une arête."""
weight(edge::AbstractEdge) = edge.weight

"""Affiche une arête."""
function show(edge::AbstractEdge)
  println("Edge ", nodes(edge), ", weight: ", weight(edge))
end