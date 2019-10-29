include(joinpath(@__DIR__, "..", "phase1", "graph.jl"))
include(joinpath(@__DIR__, "..", "phase2", "parent_table.jl"))
include(joinpath(@__DIR__, "..", "phase3", "queue.jl"))

"""Renvoie un arbre de recouvrement minimal du graphe symétrique en entrée en
utilisant l'algorithme de Kruskal. La méthode renvoie un objet de type Graph.
ATTENTION : dans le graphe en entrée, les noeuds doivent tous avoir un attribut "name" différent.
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
        # Si les deux noeuds ont des racines différentes, on ajoute l'arête à l'arbre de recouvrement minimum puis on réunit les
        # composantes connexes en désignant l'une des deux racines comme le nouveau parent de l'autre racine.
        if root(parent_table, node1) !== root(parent_table, node2)
            # On utilise un !== au lieu d'un != car les noeuds sont ordonnés selon leur poids minimum "min_weight" pour l'algorithme de Prim.
            add_edge!(min_tree, edge)
            unite!(parent_table, node1, node2)
        end
    end
    # # Le code suivant permet de tester que l'union via le rang et la compression se font correctement :
    # for node in enfants(parent_table)
    #     # On a prouvé que le rang d'un noeud doit rester inférieur à log2(s), où s est le nombre de sommets du graphe.
    #     if rank(parent_table, node) >= log2(length(enfants(parent_table)))
    #         error("Le rang du noeud ", name(node), " est supérieur à log2(s) : l'union via le rang est mal implémentée.")
    #     end
    #     # Si la compression se fait bien, les noeuds ont tous le même parent, qui est aussi leur racine.
    #     if root(parent_table, node) !== root(parent_table, enfants(parent_table)[1])
    #         error("Les noeuds n'ont pas tous le même parent : la compression des chemins est mal implémentée.")
    #     end
    #     if root(parent_table, node) !== parent(parent_table, node)
    #         error("Le parent du noeud ", name(node), " n'est pas sa racine : la compression des chemins est mal implémentée.")
    #     end
    # end
    # # On affiche puis on renvoie l'arbre de recouvrement minimum.
    # show(min_tree)
    min_tree
end


"""Renvoie un arbre de recouvrement minimal du graphe symétrique et du noeud en
entrée en utilisant l'algorithme de Prim. La méthode renvoie un objet de type Graph.
ATTENTION : dans le graphe en entrée, les noeuds doivent tous avoir un attribut "name" différent.
"""
function prim(graph::AbstractGraph{T}, starting_node::AbstractNode) where T
    parent_table = init_parent_table_prim(graph)
    # On attribue un poids nul au noeud de départ et on stocke les noeuds dans une file de priorité par poids.
    set_min_weight!(starting_node, 0.0)
    nodes_queue = PriorityQueue{Node{T}}(copy(nodes(graph)))
    # On initialise l'arbre de recouvrement minimum en lui ajoutant le sommet de départ.
    min_tree = Graph{T}("min_tree", [], [])
    add_node!(min_tree, starting_node)
    poplast!(nodes_queue)
    while length(nodes(min_tree)) < length(nodes(graph))
        # À chaque étape, on met d'abord à jour les poids des noeuds adjacents à l'arbre de recouvrement et on désigne leurs parents.
        for edge in edges(graph)
            if s_node(edge) in nodes(min_tree) && !(d_node(edge) in nodes(min_tree))
                update_parent_and_weight!(parent_table, d_node(edge), s_node(edge), weight(edge))
            elseif d_node(edge) in nodes(min_tree) && !(s_node(edge) in nodes(min_tree))
                update_parent_and_weight!(parent_table, s_node(edge), d_node(edge), weight(edge))
            end
        end
        # Puis on ajoute le noeud de poids minimum à l'arbre de recouvrement et on l'enlève de la file.
        next_node = poplast!(nodes_queue)
        add_node!(min_tree, next_node)
        add_edge!(min_tree, Edge("", parent(parent_table, next_node), next_node, min_weight(next_node)))
        update_min_weight!(next_node, 0.0)
    end
    # # Le code suivant permet de vérifer que la file de priorité est vide à la fin de l'algorithme.
    # if length(nodes_queue) > 0
    #     error(length(nodes_queue), " noeuds n'ont pas été ajoutés à l'arbre de recouvrement minimum.")
    # end
    # # On affiche puis on renvoie l'arbre de recouvrement minimum.
    # show(min_tree)
    min_tree
end
