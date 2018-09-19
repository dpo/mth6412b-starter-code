"""Nous n'avons pas typé la classe AbstractEdge ou Edge.
Lorsqu'on attribut un type à la classe Edge, cela provoque un conflit avec
le type de la classe Node.
"""
import Base.show

"""Type abstrait dont d'autres types de noeuds dériveront."""
abstract type AbstractEdge end
# abstract type AbstractEdge{T} end

"""Type représentant les arêtes d'un graphe.
L'information contenue dans une arête est les deux sommets qui sont lié pas
l'arête ainsi que son poids.

Exemple:

        arete = Edge("arete1", noeud1, noeud2, 3)

"""
mutable struct Edge <: AbstractEdge
# mutable struct Edge{T} <: AbstractEdge{T}
    node1 :: Node
    node2 :: Node
    weight :: Int
end


"""Renvoie les sommets que l'arête connecte"""
nodes(edge :: AbstractEdge) = edge.node1, edge.node2

"""Renvoie le poid d'une arête"""
weight(edge :: AbstractEdge) = edge.weight

"""Affiche une arête, c'est-à-dire les sommets relié ainsi que son poids."""
function show(edge :: AbstractEdge)
    s = string("Edge connecting Nodes ", name(edge.node1),
               "--", name(edge.node2),
               "; Poid ", weight(edge))
    println(s)
end
