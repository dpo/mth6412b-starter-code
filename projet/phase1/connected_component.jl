""" abstract type for connected components of a graph """
abstract type AbstractConnectedComponent{T,P} <: AbstractGraph{T,P} end

""" Write doc """
mutable struct ConnectedComponent{T,P} <: AbstractConnectedComponent{T,P}
    root::String
    nodes::Vector{Node{T}}
    edges::Vector{Edge{P}} 
end

root(connected_component::AbstractConnectedComponent) = connected_component.root


""" Write doc """
function kruskal(graph::Graph{T,P}) where {T,P}
    # 1. collect all nodes as connected components
    # connected_components = sort!([ConnectedComponent(name(node), [node], Vector{Edge{P}}()) for node in nodes(graph)], by=root)
    connected_components = Dict(comp.root => comp for comp in [ConnectedComponent(name(node), [node], Vector{Edge{P}}()) for node in nodes(graph)])

    # 2. Order the edges by weight (smallest to biggest)
    ordered_edges = sort(edges(graph), by=value, rev=true)

    # 3. adding iteratively edges
    while(length(connected_components) > 1)
        smallest_edge = pop!(ordered_edges)
        # finding components linked by the smallest edges in the original graph, but not yet connected in the MST
        biggest_component, smallest_component = get_components(nodes(smallest_edge), connected_components)
        if biggest_component.root != smallest_component.root
            merged_component = merge_components!(biggest_component, smallest_component)
            add_edge!(merged_component, smallest_edge)
            connected_components[merged_component.root] = merged_component
            delete!(connected_components, smallest_component.root)
        end
    end
    minimal_spanning_tree = collect(values(connected_components))[1]
    return minimal_spanning_tree
end

""" Write doc """
function get_components(node_names::Tuple{String, String}, connected_components::Dict{String, ConnectedComponent{T,P}}) where {T,P}

    components = Vector{ConnectedComponent{T,P}}()
    for connected_component in connected_components
        for node in nodes(connected_component[2])
            if name(node) in node_names
                push!(components, connected_component[2])
            end
            if length(components) == 2
                sort!(components, by= x -> length(nodes(x)), rev=true)
                return Tuple(components)
            end
        end
    end
    throw(error("the nodes aren't in any connected component"))
end

""" Write doc """
function merge_components!(biggest_component::ConnectedComponent{T,P}, smallest_component::ConnectedComponent{T,P}) where {T,P}

    for node in nodes(smallest_component)
        add_node!(biggest_component, node)
    end
    for edge in edges(smallest_component)
        add_edge!(biggest_component, edge)
    end
    smallest_component = nothing

    return biggest_component 
end

"""prints a graph"""
function show(MST::ConnectedComponent, graph::Graph)
  println("MST of the graph ", name(graph), " has ", length(nodes(MST)), " nodes.")
  for node in nodes(MST)
    show(node)
  end
  for edge in edges(MST)
    show(edge)
  end
end