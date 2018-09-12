import Base.show

"""Type abstrait dont d'autres types d'arrêtes dériveront."""
abstract type AbstractEdge{T} end

"""Type représentant les arrêtes d'un graphe.

Exemple:

        edge = Edge(pare_noeud, existe?, poids)

"""

mutable struct Edge{T} <: AbstractEdge{T}
    nodes::Array{Node{T},1}
    exists::Bool
    weigth::Int64
end

# on présume que toutes les arretes dérivant d'AbstractEdge
# posséderont des champs `noeud`, `data` et `voisins`.

"""Renvoie l'existence d'une arrete si elle existe et 0 sinon"""
exists(edge::AbstractEdge) = edge.exists

"""Renvoie le poid d'une arrete si elle existe et 0 sinon"""
weigth(edge::AbstractEdge) = edge.weigth*edge.exists

"""Renvoie les noeuds d'une arrete"""
nodes(edge::AbstractEdge) = name.(edge.nodes)

"""Affiche une arrête"""
function show(edge::AbstractEdge)
    s = string("Nodes ", nodes(edge), ", Exists", exists(edge),", Weigth", weigth(edge))
    println(s)
end
