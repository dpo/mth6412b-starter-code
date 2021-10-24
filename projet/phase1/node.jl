import Base.show
import Base.isless

"""Type abstrait dont d'autres types de noeuds dériveront."""
abstract type AbstractNode{T} end

"""Type représentant les noeuds d'un graphe.

Exemple:

  noeud = Node("James", [π, exp(1)], 1)
  noeud = Node("Kirk", "guitar")

"""
mutable struct Node{T} <: AbstractNode{T}
  name::String
  coordinates::T
  rank::Int
  min_weight::Float64
  parent::Union{Node{T}, Nothing}
end
Node(name::String, coordinates::T; rank::Int=0, min_weight::Float64=Inf,
     parent::Union{Node{T}, Nothing}=nothing) where T = Node(name, coordinates, rank, min_weight, parent)

"""Renvoie le nom du noeud."""
name(node::AbstractNode) = node.name
name(::Nothing) = nothing

"""Renvoie le rang du noeud."""
rank(node::AbstractNode) = node.rank

"""Renvoie les données contenues dans le noeud."""
coordinates(node::AbstractNode) = node.coordinates

"""Renvoie le poids minimal du noeud."""
min_weight(node::AbstractNode) = node.min_weight

"""Renvoie le parent du noeud."""
parent(node::AbstractNode) = node.parent

"""Affiche un noeud."""
function show(node::AbstractNode)
  println("Node ", name(node), ", coordonnées: ", coordinates(node), 
          " rang: ", rank(node), " min_weight: ", min_weight(node), " parent: ", name(parent(node)))
end

#"""Méthode pour comparer deux sommets par leur rang"""
#isless(p::Node, q::Node) = rank(p) < rank(q)