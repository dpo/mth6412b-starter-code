import Base.show

"""Type abstrait dont d'autres types d'arètes dériveront."""
abstract type AbstractEdge{I, J} end

"""Type représentant les arètes d'un graphe.

Exemple:

  edge = Edge("Mtl_Qc", (node1, node2), 20)

"""
mutable struct Edge{I, J} <: AbstractEdge{I, J}
  name::String
  data::Tuple{Node{I}, Node{I}}
  weight::J
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
