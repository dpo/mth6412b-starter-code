import Base.show

"""Type abstrait dont d'autres types d'arrêtes dériveront."""
abstract type AbstractEdge{T} end

"""Type représentant les arrêtes d'un graphe.

Exemple:

        edge = Edge("James", "Kirk", 5)

"""

mutable struct Edge{T} <: AbstractEdge{T}
    nodeA::Node{T}
    nodeB::Node{T}
    weight::Int64
end

# on présume que toutes les arrêtes dérivant d'AbstractEdge
# posséderont des champs `nodeA`, `nodeB` et `weight`.

"""Renvoie les noeuds d'une arrête"""
nodes(edge::AbstractEdge) = [edge.nodeA,edge.nodeB]

"""Renvoie le poid d'une arrête"""
weight(edge::AbstractEdge) = edge.weight

"""Affiche une arrête"""
function show(edge::AbstractEdge)
    s = string("Nodes: ", name.(nodes(edge)), "; Weight: ", weight(edge))
    println(s)
end
