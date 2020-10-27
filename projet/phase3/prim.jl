""" Prim Algortihm
    
takes a Graph{T,P} as an argument

returns mininmal spanning tree of the graph
"""
function prim(graph::Graph{T,P}) where {T,P}

    graph_nodes = Dict(name(node) => node for node in nodes(graph))

    # By default the random node is the first one in the list of nodes
    random_node = nodes(graph)[1]
    minimal_spanning_tree = ConnectedComponent(name(random_node), [random_node], Vector{Edge{P}}(), 0)
    ordered_edges = sort(edges(graph), by=value, rev=false)
    while length(nodes(minimal_spanning_tree)) != length(nodes(graph))
        node_names = [name(connected_node) for connected_node in nodes(minimal_spanning_tree)]
        contains_node, edge = find_edges(node_names, ordered_edges) 
        if contains_node[1]
            add_node!(minimal_spanning_tree, graph_nodes[nodes(edge)[1]])
        elseif contains_node[2]
            add_node!(minimal_spanning_tree, graph_nodes[nodes(edge)[2]])
        end
        add_edge!(minimal_spanning_tree, edge)
    end

    return  minimal_spanning_tree, total_weight(minimal_spanning_tree)

end

function find_edges(node_names::Vector{String}, ordered_edges::Vector{Edge{P}}) where P

    for edge in ordered_edges
        contains_node = [isnothing(findfirst(x-> x == edge.nodes[1], node_names)), isnothing(findfirst(x-> x == edge.nodes[2], node_names))]
        if contains_node[1] != contains_node[2]
            return contains_node, edge
        end
    end
end

