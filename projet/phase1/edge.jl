import Base.show


"""Type abstrait dont d'autres types d'aretes dériveront."""
abstract type AbstractEdge{T} end

"""Type représentant les aretes d'un graphe.
"""


mutable struct Edge{T} <: AbstractEdge{T}
  ends::Tuple{Node{T}, Node{T}}
  weight::Int
end


ends(edge::AbstractEdge) = edge.ends


weight(edge::AbstractEdge) = edge.weight


function show(edge::AbstractEdge)
  println( "Edge  $(ends(edge))  weight: $(weight(edge))" )
end
