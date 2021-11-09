import Base.show
import Base.isless

"""Type abstrait dont d'autres types d'arètes dériveront."""
abstract type AbstractEdge{T, I} end

"""Type représentant les arètes d'un graphe.

Exemple:

  edge = Edge("Mtl_Qc", (node1, node2), 20)

"""
mutable struct Edge{T, I} <: AbstractEdge{T, I}
  name::String
  data::Tuple{Node{T}, Node{T}}
  weight::I
end

# on présume que tous les arètes dérivant d'AbstractEdge
# posséderont des champs `name`, `data` et `weight`.

"""Renvoie le nom de l'arète."""
name(edge::AbstractEdge) = edge.name

"""Renvoie les données contenues dans l'arète."""
data(edge::AbstractEdge) = edge.data

"""Renvoie les poids de l'arète."""
weight(edge::AbstractEdge) = edge.weight

"""Affiche une arète."""
function show(edge::AbstractEdge)
  println("Edge ", name(edge), ", data: (", name(data(edge)[1]), ", ", name(data(edge)[2]), "), weight: ", weight(edge))
end

"""Méthode pour comparer deux arêtes par leur poids"""
isless(p::Edge, q::Edge) = weight(p) < weight(q)

"""
Ajoute une extrémité de edge dans les voisins de l'autre et inversement.
"""
function add_voisins!(edge::Edge{T, I}) where {T, I}
  push!(edge.data[1].voisins, data(edge)[2])
  push!(edge.data[1].voisinweights, weight(edge))
  push!(edge.data[2].voisins, data(edge)[1])
  push!(edge.data[2].voisinweights, weight(edge))
end