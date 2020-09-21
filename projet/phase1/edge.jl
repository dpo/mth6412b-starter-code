import Base.show

abstract type AbstractEdge{T} end


# In the future, this edge will have to implement directionality
mutable struct Edge{T} <: AbstractEdge{T}
    nodes::Tuple{Node{T}, Node{T}}
    value::T
end

nodes(edge::AbstractEdge) = edge.nodes
value(edge::AbstractEdge) = edge.value


"""Affiche une arête."""
function show(edge::AbstractEdge)
  println("Edge nodes: ", nodes(edge), ", value: ", value(edge))
end