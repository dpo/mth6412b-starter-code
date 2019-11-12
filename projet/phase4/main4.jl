include(joinpath(@__DIR__, "..", "phase1", "graph.jl"))
include(joinpath(@__DIR__, "..", "phase2", "parent_table.jl"))
include(joinpath(@__DIR__, "..", "phase3", "priority_queue.jl"))
include(joinpath(@__DIR__, "..", "phase4", "degree_table.jl"))

"""Renvoie une tournée optimisée passant par tous les points du graphe symétrique
en entrée en utilisant l'algorithme de Rosenkrantz, Stearns et Lewis. Par défaut,
le premier noeud du graphe est choisi comme point de départ. La méthode renvoie un
objet de type Graph contenant cette tournée.
ATTENTION : dans le graphe en entrée, les noeuds doivent tous avoir un attribut "name" différent.
"""
function RSL_prim(graph::AbstractGraph{T}, starting_node::AbstractNode = nodes(graph)[1]) where T
    # On initialise les poids des noeuds à plus l'infini.
    set_min_weight!.(nodes(graph), Inf)
    parent_table = init_parent_table_prim(graph)
    # On attribue un poids nul au noeud de départ et on stocke les noeuds dans une file de priorité par poids.
    set_min_weight!(starting_node, -Inf)
    nodes_queue = PriorityQueue{Node{T}}(copy(nodes(graph)))
    # On initialise l'arbre de recouvrement minimum en lui ajoutant le sommet de départ.
    min_tree = Graph{T}("min_tree", [], [])
    RSL_tree = Graph{T}("RSL_tree", [], [])
    add_node!(min_tree, starting_node)
    add_node!(RSL_tree, starting_node)
    poplast!(nodes_queue)
    while length(nodes(min_tree)) < length(nodes(graph))
        # À chaque étape, on met d'abord à jour les poids des noeuds adjacents à l'arbre de recouvrement et on désigne leurs parents.
        # Pour cela, on sélectionne uniquement les arêtes dont un seul des sommets est dans l'arbre de recouvrement :
        for edge in filter(e -> !(s_node(e) in nodes(min_tree) && d_node(e) in nodes(min_tree)) && (s_node(e) in nodes(min_tree) || d_node(e) in nodes(min_tree)), edges(graph))
            if s_node(edge) in nodes(min_tree)
                update_parent_and_weight!(parent_table, d_node(edge), s_node(edge), weight(edge))
            elseif d_node(edge) in nodes(min_tree)
                update_parent_and_weight!(parent_table, s_node(edge), d_node(edge), weight(edge))
            end
        end
        # Puis on ajoute le noeud de poids minimum à l'arbre de recouvrement et on l'enlève de la file.
        next_node = poplast!(nodes_queue)
        add_node!(min_tree, next_node)
        add_node!(RSL_tree, next_node)
        add_edge!(min_tree, Edge("", parent(parent_table, next_node), next_node, min_weight(next_node)))
        add_edge!(RSL_tree, Edge("", nodes(RSL_tree)[end], nodes(RSL_tree)[end - 1], findweight(graph, nodes(RSL_tree)[end], nodes(RSL_tree)[end - 1])))
        set_min_weight!(next_node, -Inf)
    end
    # On renvoie la tournée optimisée :
    RSL_tree
end

"""À partir du graphe en entrée, construit et renvoie un 1-arbre de coût modifié minimum
selon l'algorithme de Prim. Le coût modifié de chaque arête est le poids de cette arête
plus le poids dans la liste "n_pi" de chacune de ses extrémités.
"""
function build_one_tree(graph::AbstractGraph, n_pi::Vector{Float64}, starting_node::AbstractNode = nodes(graph)[1])
    edges_copy = copy(edges(graph))
    for e in edges(graph)
        weight(e) = weight(e) + n_pi[s_node(e)] + n_pi[dnode(e)]
    end
    one_tree = prim(graph, starting_node)
    addedge!(one_tree, sort(filter(e -> !(e in edges(one_tree)), edges(graph)), by=weight)[1])
    edges(graph) = edges_copy
    one_tree
end

"""Calcule et renvoie la borne inférieure "w" que l'algorithme de Held et Karp cherche à maximiser."""
function w(one_tree::AbstractGraph{T}, degree_table::AbstractDegreeTable{T}, n_pi::Vector{Float64}) where T
    return graphweight(one_tree) + sum(degrees(degree_table)[i] * n_pi[i] for i = 1 : length(n_pi))
end

"""Renvoie une tournée optimisée passant par tous les points du graphe symétrique
en entrée en utilisant l'algorithme de Held et Karp. La méthode renvoie un objet
de type Graph contenant la meilleure tournée obtenue après "max_iter" itérations.
ATTENTION : dans le graphe en entrée, les noeuds doivent tous avoir un attribut "name" différent.
"""
function HK(graph::AbstractGraph{T}, step::Float64 = , starting_node::AbstractNode = nodes(graph)[1], max_iter::Int64 = 100) where T
    n_pi = Vector{Float64}(ones(length(nodes(graph))))
    max_w = -Inf
    max_n_pi = n_pi
    iter = 0
    while  && iter < max_iter
        one_tree = build_one_tree(graph, n_pi, starting_node)
        degree_table = degree_table(one_tree)
        w = w(one_tree, degree_table, n_pi)
        if w > max_w
            max_w = w
            max_n_pi = n_pi
        end
        n_pi += step * (degree_table - 2)


    end
end
