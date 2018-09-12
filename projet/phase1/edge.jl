import Base.show

"""Type abstrait dont d'autres types d'arrêtes dériveront."""
abstract type AbstractEdge{T} end

"""Type représentant les arrêtes d'un graphe.

Exemple:

        edge = Edge(pare_noeud, existe?, poids)

"""

mutable struct Edge{T} <: AbstractEdge{T}
    nodes::Array{Node{T},1}
    weigth::Int64
end

# on présume que toutes les arretes dérivant d'AbstractEdge
# posséderont des champs `noeud`, `data` et `voisins`.


"""Renvoie le poid d'une arrete"""
weigth(edge::AbstractEdge) = edge.weigth

"""Renvoie les noeuds d'une arrete"""
nodes(edge::AbstractEdge) = name.(edge.nodes)

"""Affiche une arrête"""
function show(edge::AbstractEdge)
    s = string("Nodes ", nodes(edge), ", Weigth ", weigth(edge))
    println(s)
end
