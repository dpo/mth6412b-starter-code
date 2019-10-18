

include(joinpath(@__DIR__, "..", "phase1", "graph.jl"))
include(joinpath(@__DIR__, "..", "phase2", "parent_table.jl"))

"""Renvoie un arbre de recouvrement minimal du graphe symétrique en entrée en
utilisant l'algorithme de Kruskal. La méthode renvoie un objet de type Graph.
"""
function kruskal(graph::AbstractGraph{T}) where T
    parent_table = init_parent_table_kruskal(graph)
    # on trie les arêtes par poids croissant.
    edges_copy = copy(edges(graph))
    sort!(edges_copy, by=weight)
    # On initialise l'arbre de recouvrement minimum en lui ajoutant tous les sommets du graphe.
    min_tree = Graph{T}("min_tree", [], [])
    for node in nodes(graph)
        add_node!(min_tree, node)
    end
    # On parcourt les arêtes du graphe.
    for edge in edges_copy
        # On récupère les extrémités de l'arête.
        node1 = s_node(edge)
        node2 = d_node(edge)
        # Si les deux noeuds ont des racines différentes, on ajoute
        # l'arête à l'arbre de recouvrement minimum puis on réunit les
        # composantes connexes en désignant l'une des deux racines comme
        # le nouveau parent de l'autre racine.
        if root(parent_table, node1) != root(parent_table, node2)
            add_edge!(min_tree, edge)
            unite!(parent_table, node1, node2)
        end
    end
    # On affiche puis on renvoie l'arbre de recouvrement minimum.
    show(min_tree)
    min_tree
end


"""Renvoie un arbre de recouvrement minimal du graphe symétrique et du noeud en
entrée en utilisant l'algorithme de Prim. La méthode renvoie un objet de type Graph.
"""
function prim(graph::AbstractGraph{T}, starting_node::AbstractNode) where T
    parent_table = init_parent_table_prim(graph)
    # On attribue un poids nul au noeud de départ et on trie les noeuds par poids croissant.
    set_min_weight(starting_node, 0)
    nodes_queue = PriorityQueue{Nodes{T}}(copy(nodes(graph)))
    # On initialise l'arbre de recouvrement minimum en lui ajoutant le sommet de départ.
    min_tree = Graph{T}("min_tree", [], [])
    add_node!(min_tree, starting_node)
    popfirst!(nodes_queue)
    # On initialise les poids des noeuds voisins du noeud de départ.
    for edge in edges(graph)
        if s_node(edge) == starting_node
            set_min_weight(d_node(edge), weight(edge))
            set_parent!(parent_table, d_node(edge), starting_node)
        end
        if d_node(edge) == starting_node
            set_min_weight(s_node(edge), weight(edge))
            set_parent!(parent_table, s_node(edge), starting_node)
        end
    end
    while length(nodes(min_tree)) < length(nodes(graph))
        next_node = popfirst!(nodes_queue)
        add_node!(min_tree, next_node)
        add_edge!(min_tree, parent(parent_table, next_node), next_node, min_weight(next_node))
        popfirst!(nodes_queue)
        for edge in edges(graph)
            if s_node(edge) == next_node
                set_min_weight(d_node(edge), weight(edge))
                set_parent!(parent_table, d_node(edge), next_node)
            end
            if d_node(edge) == next_node
                set_min_weight(s_node(edge), weight(edge))
                set_parent!(parent_table, s_node(edge), next_node)
            end
        end
    end
    show(min_tree)
    min_tree
end
