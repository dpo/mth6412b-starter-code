import Base.show

abstract type AbstractEdge{T} end


# In the future, this edge will have to implement directionality
mutable struct Edge <: AbstractEdge{T} end
    nodes::Tuple{Node, Node}
    value::T
end