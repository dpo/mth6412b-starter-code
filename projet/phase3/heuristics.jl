""" First Heuristic: Merge Disjoint sets using the rank""" 
function merge_disjoint_components_by_rank!(forest::Vector{ConnectedComponent{T,P}}) where {T,P}

    # 1. Set all ranks to 0 initially:
    ranks = Dict{String, Int64}()
    for component in forest
        ranks[root(component)] = 0 
    end

    # 2. iteratively merging the components while updating the ranks:
    # We will merge all components to the first one. This is an arbitrary choice.
    first_component = forest[1]
    for component in forest[2:length(forest)]
        # the new edge has a weight of 1. It is arbitrary.
        new_edge = Edge((root(first_component), root(component)), 1)
        first_component_rank = ranks[root(first_component)]
        other_component_rank = ranks[root(component)]
        if other_component_rank < first_component_rank
            first_component = merge_components!(first_component, component, new_edge)
        elseif other_component_rank > first_component_rank
            first_component = merge_components!(component, first_component, new_edge)
        else
            first_component = merge_components!(first_component, component, new_edge)
            ranks[root(first_component)] += 1 
        end
    end
    return first_component , ranks
end