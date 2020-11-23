abstract type AbstractEdge{T} end

"""
    Edge{T}
"""
mutable struct Edge{T} <: AbstractEdge{T}
    nodes::Tuple{Int, Int}
    weight::Float64
end

"""
    nodes(e)

Return the extremities of node `e`
"""
nodes(e::Edge{T}) where{T} = e.nodes

"""
    weight(e)

Return the weight of edge `e`
"""
weight(e::Edge{T}) where{T} = e.weight

"""Show an edge."""
function show(e::Edge{T}) where{T}
    println("Edge (", e.nodes[1], ",", e.nodes[2], ") of weight ", weight(e))
    return nothing
end

