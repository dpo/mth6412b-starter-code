import Base.show
# une ligne de commentaire
"""Type abstrait dont d'autres types de noeuds dériveront."""
abstract type AbstractNode{T} end

"""Type représentant les noeuds d'un graphe.

Exemple:

    noeud = Node("James", [π, exp(1)])
    noeud = Node("Kirk", "guitar")
    noeud = Node("Lars", 2)
"""
mutable struct Node{T} <: AbstractNode{T}
  name::String
  data::T
  id::Int64
end

# on présume que tous les noeuds dérivant d'AbstractNode
# posséderont des champs `name` et `data`.

"""Renvoie le nom du noeud."""
name(node::Node) = node.name

"""Renvoie les données contenues dans le noeud."""
data(node::Node) = node.data

"""Affiche un noeud."""
function show(node::Node)
  println("Node ", name(node))#, ", data: ", data(node))
end

# new line for test commit
