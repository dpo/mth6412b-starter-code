"""TODO"""

function hk(graph::Graph{T,P}; is_kruskal = true, step_size_0::Float64 = 1.0, ϵ::Float64 = 1*10^-5, version = lin_kernighan, timer::Int64 = 60) where {T,P}
    # Compute Minimal Spanning Tree of the graph:
    
    π = zeros(Float64, length(nodes(graph)))
    gradient = [-2.0 for i in 1:length(π)]  
    
    period =  version == slow_convergence ? [1] : [(length(π) ÷ 2)]

    one_tree = Graph("1-tree", nodes(graph), Vector{Edge{P}}())
    one_tree_best = one_tree
    best_W = -Inf
    # The first element is the previous value of W, the second element is the current value of W
    W_state = [-Inf, -Inf]
    stop_doubling = version == slow_convergence ? true : false
    step_size = step_size_0
    start = time()
    while norm(gradient) > ϵ  && period[end] > 0 && step_size > ϵ  && (time() - start) < timer && (abs(W_state[1] - W_state[2]) > ϵ || length(period) <= 1)
        
        for iter in 1:period[end]     
            (time() - start) > timer && break
            
            # update edge weights based on the node names:
            pi_graph=Graph("pi_graph",nodes(graph),Vector{Edge{P}}())
            for edge in edges(graph)
                new_edge=Edge(nodes(edge),value(edge))
                first_node_name, second_node_name = map(x-> parse(Int, x), nodes(edge))
                new_edge.value += π[first_node_name] + π[second_node_name] 
                add_edge!(pi_graph,new_edge)
            end
            mst, mst_weight = is_kruskal ? kruskal(pi_graph) : prim(pi_graph)
            
            # build a 1-tree:
            one_tree = Graph("1-tree", nodes(pi_graph), sort!(edges(mst), by = value))
            sorted_graph_edges = sort!(edges(pi_graph), by = value)

            # Finding the smallest edge not in mst and adding it to 1-tree graph
            idx = findfirst(edge -> !(edge ∈ edges(one_tree)), sorted_graph_edges)
            new_smallest_edge = !isnothing(idx) ? sorted_graph_edges[idx] : return
            add_edge!(one_tree, new_smallest_edge)

            # updating total_weights:
            W_state[1] = W_state[2]
            W_state[2] = total_weight(one_tree) - (2 * sum(x -> x, π))
            if best_W<W_state[2]
                best_W=W_state[2]
                one_tree_best=one_tree
            end
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
            println("iter:", Int(norm(period,1)-period[end]+iter))
            println("gradient: ", norm(gradient), " step: ",step_size, " Last period: ", period[end])
            println("W: " , W_state[2])
            println(" ")
        end
        if version == slow_convergence
            new_period = 1
        else
            new_period=W_state[1] < W_state[2] ? period[end] * 2 : period[end] ÷ 2
        end
        step_size = (version == slow_convergence) ? step_size_0 / norm(period, 1) : step_size / 2
        push!(period, new_period)
    end

    return one_tree_best, best_W
end