import Base.show

"""Type abstrait dont d'autres types d'aretes dériveront."""
abstract type AbstracEdge{T} end

"""Type représentant les aretes d'un graphe.

"""
mutable struct Edge{T} <: AbstractEdge{T}
    ### TODO pas nescessaire de differencier les extremite
    start_node::AbstractNode{T}
    end_node::AbstractNode{T}
    weight::Int
    @warn "Est ce que le type du poid est forcement int?"
end


start_node(edge::AbstractEdge) = edge.start_node
end_node(edge::AbstractEdge) = edge.end_node


weight(edge::AbstractEdge) = edge.weight


function show(edge::AbstractEdge)
  println( "Edge  $(start_node(edge)) to $(end_node(edge)) weight: $(weight(edge))" )
end

end