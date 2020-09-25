import Base.show

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
end

"""Constructs a node by giving a pair as an argument"""
function Node(dict::Dict{Int64, Vector{Float64}})  
  if length(dict) != 1
    throw(NodeError("invalid dictionary given to build Node"))
  end
  name = ""
  data = Float64[]
  for elem in dict
    name = "$(elem[1])"
    data = elem[2]
  end
  return Node(name, data) 
end
# on présume que tous les noeuds dérivant d'AbstractNode
# posséderont des champs `name` et `data`.

"""Renvoie le nom du noeud."""
name(node::AbstractNode) = node.name

"""Renvoie les données contenues dans le noeud."""
data(node::AbstractNode) = node.data



"""Affiche un noeud."""
function show(node::AbstractNode)
  println("Node ", name(node), ", data: ", data(node))
end
