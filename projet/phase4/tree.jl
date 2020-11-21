"""TODO"""
mutable struct Tree{P}
    data::String
    parent:: Union{Tree{P}, Nothing}
    children:: Vector{Tree{P}}
    parent_weight::Union{P, Nothing}
end
"""TODO """
data(tree::Tree{P}) where{P} = tree.data

""" TODO"""
function Tree(cp::ConnectedComponent{T,P}) where {T,P}
    root = Tree(cp.root, nothing, Vector{Tree{P}}(), nothing)
    edge_queue = copy(edges(cp))
    tree_stack = Vector{Tree{P}}()
    push!(tree_stack, root)
    while(length(edge_queue) != 0)
        added_trees = Vector{Tree{P}}()
        edge_idx_to_delete = Vector{Int64}()
        for (idx, edge) in enumerate(edge_queue)
            node_names = [node_name for node_name in nodes(edge)]
            for tree in tree_stack
                potential_children = [node_name for node_name in node_names if node_name != data(tree)]
                if length(potential_children) == 1
                    potential_children = pop!(potential_children)
                    new_tree = Tree(potential_children, tree, Vector{Tree{P}}(), value(edge))
                    push!(tree.children, new_tree)
                    push!(added_trees, new_tree)
                    push!(edge_idx_to_delete, idx)
                    break
                end
            end
        end
        for index in edge_idx_to_delete
            popat!(edge_queue, index)
            edge_idx_to_delete[findfirst(x -> x == index, edge_idx_to_delete):end] .-= 1
        end
        tree_stack = added_trees
    end
    return root
end

""" TODO"""
function dfs(tree::Tree)
    preorder = Vector{String}()
    push!(preorder, data(tree))
    # Go through the children first:
    [dfs(child, preorder) for child in tree.children if !isnothing(tree.children)]
    return preorder
end

function dfs(tree::Tree, preorder::Vector{String})
    push!(preorder, data(tree))
    [dfs(child, preorder) for child in tree.children if !isnothing(tree.children)]
end