"""TODO"""
function hk(graph::Graph{T,P}; is_kruskal = true, step_size::Float64 = 1.0, ϵ::Float64 = 1*10^-5) where {T,P}
    # Compute Minimal Spanning Tree of the graph:
    π = zeros(Float64, length(nodes(graph)))
    gradient = [-2.0 for i in 1:length(π)]  
    # period = [(length(π) ÷ 2)]
    period = [1]
    one_tree = Graph("1-tree", nodes(graph), Vector{Edge{P}}())

    # The first element is the previous value of W, the second element is the current value of W
    W_state = [-Inf, -Inf]
    stop_doubling = false

    while norm(gradient) > ϵ && step_size > ϵ && period[end] > 0
        for iter in 1:period[end]     # update edge weights based on the node names:
            for edge in edges(graph)
                first_node_name, second_node_name = map(x-> parse(Int, x), nodes(edge))
                edge.value += π[first_node_name] + π[second_node_name] 
            end
            mst, mst_weight = is_kruskal ? kruskal(graph) : prim(graph)
            
            # build a 1-tree:
            one_tree = Graph("1-tree", nodes(graph), sort!(edges(mst), by = value))
            sorted_graph_edges = sort!(edges(graph), by = value)

            # Finding the smallest edge not in mst and adding it to 1-tree graph
            idx = findfirst(edge -> !(edge ∈ edges(one_tree)), sorted_graph_edges)
            new_smallest_edge = !isnothing(idx) ? sorted_graph_edges[idx] : return
            add_edge!(one_tree, new_smallest_edge)

            # updating total_weights:
            W_state[1] = W_state[2]
            W_state[2] = total_weight(one_tree) - (2 * sum(x -> x, π))

            # checking if we have to stop doubling the step size:
            if length(period) == 1 && !stop_doubling && W_state[1] < W_state[2]
                step_size *= 2
            else
                stop_doubling = true   
            end

            gradient = [-2.0 for i in 1:length(π)]
            for edge in edges(one_tree)
                first_node_name, second_node_name = map(x-> parse(Int, x), nodes(edge))
                gradient[first_node_name] += 1
                gradient[second_node_name] += 1
            end
            π = π .+ (step_size * gradient)
            println(W_state[2])
        end
        new_period = W_state[1] < W_state[2] ? period[end] * 2 : period[end] ÷ 2
        step_size = 1 / norm(period, 1)
        push!(period, new_period)
        
    end
    
    return one_tree, total_weight(one_tree) - (2 * sum(x -> x, π))
end