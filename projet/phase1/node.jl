import Base.show
import Base.isless

"""Type abstrait dont d'autres types de noeuds dériveront."""
abstract type AbstractNode{T} end

"""Type représentant les noeuds d'un graphe.
Voisins est un vecteur de tuples contenant un voisin et le cout associé à l'arête les reliant.

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
  voisins::Vector{Tuple{Node{T}, Float64}}
  enfants::Vector{Node{T}}
end
Node(
  name::String,
  coordinates::T,
  rank::Int=0,
  min_weight::Float64=Inf,
  parent::Union{Node{T}, Nothing}=nothing,
  voisins=Tuple{Node{T}, Float64}[],
  enfants = Node{T}[],
  ) where T = Node(name, coordinates, rank, min_weight, parent, voisins, enfants)

"""
Ajoute le node1 aux enfants de node2.
"""
function add_enfant!(parent::Node{T}, enfant::Node{T}) where {T}
  push!(parent.enfants, enfant)
end

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

"""Renvoie les voisins du noeud."""
voisins(node::AbstractNode) = node.voisins

"""Renvoie les enfants du noeud."""
enfants(node::AbstractNode) = node.enfants

"""Affiche un noeud."""
function show(node::Node)
  println("Node ", name(node), ", coordonnées: ", coordinates(node), 
          " rang: ", rank(node), " min_weight: ", min_weight(node), " parent: ", name(parent(node)))
end

#"""Méthode pour comparer deux sommets par leur rang"""
#isless(p::Node, q::Node) = rank(p) < rank(q)

#"""
#Type de sommet utiliser pour les arbres
#"""
#mutable struct TreeNode{T} <: AbstractNode{T}
#  name::String
#  coordinates::T
#  enfants::Union{Vector{TreeNode{T}}, Nothing}
#  parent::Union{TreeNode{T}, Nothing}
#end
#
#"""
#Renvoie la liste d'enfants d'un TreeNode
#"""
#enfants(node::TreeNode) = node.enfants
#
#function show(node::TreeNode)
#  println("Node ", name(node), ", coordonnées: ", coordinates(node), " parent: ", name(parent(node)))
#end