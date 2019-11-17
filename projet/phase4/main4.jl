include(joinpath(@__DIR__, "..", "phase1", "main1.jl"))
include(joinpath(@__DIR__, "..", "phase2", "parent_table.jl"))
include(joinpath(@__DIR__, "..", "phase3", "priority_queue.jl"))
include(joinpath(@__DIR__, "..", "phase3", "main3.jl"))
include(joinpath(@__DIR__, "..", "phase4", "degree_table.jl"))

"""À partir d'un graphe et d'un arbre de recouvrement minimum, construit et
renvoie la table des liens de parenté associée.
ATTENTION : dans le graphe en entrée, les noeuds doivent tous avoir un attribut "name" différent.
"""
function RSL_struct(min_tree::AbstractGraph{T}, starting_node::AbstractNode = nodes(min_tree)[1]) where T
    parent_table = init_parent_table_RSL(min_tree)
    q = PriorityQueue{Node{T}}([])
    node = Node{T}(name(starting_node), data(starting_node))
    node_temp = []
    set_parent!(parent_table, child_index(parent_table, node), node)
    push!(q, node)
    while !(is_empty(q))
        node_temp = []
        for edge in edges(min_tree)
            i1 = 0
            if (name(s_node(edge)) == name(node)) && (name(parent(parent_table, d_node(edge))) == "init")
                i1 = child_index(parent_table, d_node(edge))
                set_parent!(parent_table, i1, node)
                push!(q, d_node(edge))
                node_temp = d_node(edge)
            elseif (name(d_node(edge)) == name(node)) && (name(parent(parent_table, s_node(edge))) == "init")
                i1 = child_index(parent_table, s_node(edge))
                set_parent!(parent_table, i1, node)
                push!(q, s_node(edge))
                node_temp = s_node(edge)
            end
        end
        if node_temp == []
            node = popfirst!(q)
        else
            node = node_temp
        end
    end
    return(parent_table)
end

"""À partir d'un arbre de recouvrement minimum et d'un objet ParentTable contenant
les liens de parenté entre les noeuds, renvoie une tournée optimisée passant par
tous les points du graphe symétrique en entrée en utilisant l'algorithme de Rosekrantz,
Stearns et Lewis. Par défaut, le premier noeud du graphe est choisi comme point de
départ. La méthode renvoie un objet de type Graph contenant cette tournée.
ATTENTION : dans le graphe en entrée, les noeuds doivent tous avoir un attribut "name" différent.
"""
function RSL(min_tree::AbstractGraph{T}, graph::AbstractGraph, parent_table::AbstractParentTable{T} = RSL_struct(min_tree), starting_node::AbstractNode{T} = nodes(min_tree)[1]) where T
    RSL_tree = Graph{T}("RSL_tree", [], [])
    node = Node{T}(name(starting_node), data(starting_node))
    add_node!(RSL_tree, node)
    node_temp = []
    j = 0
    while nb_edges(RSL_tree) < nb_nodes(graph) - 1
        node_temp = []
        weight_temp = Inf
        for edge in edges(min_tree)
            if weight(edge) < weight_temp
                if ((name(s_node(edge)) == name(node)) && (name(parent(parent_table, d_node(edge))) == name(node)) && !(find_node(RSL_tree, d_node(edge))))
                    node_temp = d_node(edge)
                    weight_temp = weight(edge)
                elseif ((name(d_node(edge)) == name(node)) && (name(parent(parent_table, s_node(edge))) == name(node)) && !(find_node(RSL_tree, s_node(edge))))
                    node_temp = s_node(edge)
                    weight_temp = weight(edge)
                end
            end
        end
        if node_temp == []
            j += 1
            node = nodes(RSL_tree)[end - j]
        else
            j = 0
            node = node_temp
            add_node!(RSL_tree, node)
            add_edge!(RSL_tree, Edge("", nodes(RSL_tree)[end], nodes(RSL_tree)[end - 1], findweight(graph, nodes(RSL_tree)[end], nodes(RSL_tree)[end - 1])))
        end
    end
    add_edge!(RSL_tree, Edge("", nodes(RSL_tree)[end], nodes(RSL_tree)[1], findweight(graph, nodes(RSL_tree)[end], nodes(RSL_tree)[1])))
    return(RSL_tree)
end

# """Renvoie une tournée optimisée passant par tous les points du graphe symétrique
# en entrée en utilisant l'algorithme de Rosenkrantz, Stearns et Lewis et l'algorithme
# de Prim. Par défaut, le premier noeud du graphe est choisi comme point de départ.
# La méthode renvoie un objet de type Graph contenant cette tournée.
# ATTENTION : dans le graphe en entrée, les noeuds doivent tous avoir un attribut "name" différent.
# """
# function RSL_prim(graph::AbstractGraph{T}, starting_node::AbstractNode = nodes(graph)[1]) where T
#     # On initialise les poids des noeuds à plus l'infini.
#     set_min_weight!.(nodes(graph), Inf)
#     parent_table = init_parent_table_prim(graph)
#     # On attribue un poids nul au noeud de départ et on stocke les noeuds dans une file de priorité par poids.
#     set_min_weight!(starting_node, -Inf)
#     nodes_queue = PriorityQueue{Node{T}}(copy(nodes(graph)))
#     # On initialise l'arbre de recouvrement minimum en lui ajoutant le sommet de départ.
#     min_tree = Graph{T}("min_tree", [], [])
#     RSL_tree = Graph{T}("RSL_tree", [], [])
#     add_node!(min_tree, starting_node)
#     add_node!(RSL_tree, starting_node)
#     poplast!(nodes_queue)
#     while length(nodes(min_tree)) < length(nodes(graph))
#         # À chaque étape, on met d'abord à jour les poids des noeuds adjacents à l'arbre de recouvrement et on désigne leurs parents.
#         # Pour cela, on sélectionne uniquement les arêtes dont un seul des sommets est dans l'arbre de recouvrement :
#         for edge in filter(e -> !(s_node(e) in nodes(min_tree) && d_node(e) in nodes(min_tree)) && (s_node(e) in nodes(min_tree) || d_node(e) in nodes(min_tree)), edges(graph))
#             if s_node(edge) in nodes(min_tree)
#                 update_parent_and_weight!(parent_table, d_node(edge), s_node(edge), weight(edge))
#             elseif d_node(edge) in nodes(min_tree)
#                 update_parent_and_weight!(parent_table, s_node(edge), d_node(edge), weight(edge))
#             end
#         end
#         # Puis on ajoute le noeud de poids minimum à l'arbre de recouvrement et on l'enlève de la file.
#         next_node = poplast!(nodes_queue)
#         add_node!(min_tree, next_node)
#         add_node!(RSL_tree, next_node)
#         add_edge!(min_tree, Edge("", parent(parent_table, next_node), next_node, min_weight(next_node)))
#         add_edge!(RSL_tree, Edge("", nodes(RSL_tree)[end], nodes(RSL_tree)[end - 1], findweight(graph, nodes(RSL_tree)[end], nodes(RSL_tree)[end - 1])))
#         set_min_weight!(next_node, -Inf)
#     end
#     # On renvoie la tournée optimisée :
#     add_edge!(RSL_tree, filter(
#             e -> name(s_node(e)) == name(nodes(RSL_tree)[1]) && name(d_node(e)) == name(nodes(RSL_tree)[end])
#             || name(d_node(e)) == name(nodes(RSL_tree)[1]) && name(s_node(e)) == name(nodes(RSL_tree)[end]), edges(graph))[1])
#     RSL_tree
# end

"""Renvoie la valeur du coefficient d'un noeud selon la table n_pi en entrée."""
function n_pi(node::AbstractNode, nodes::Vector{Node})
    i = findfirst(name(node), name.(nodes))
    n_pi[i]
end

"""Calcule et renvoie la borne inférieure "w" que l'algorithme de Held et Karp cherche à maximiser."""
function lower_bound(one_tree::AbstractGraph{T}, degree_table::AbstractDegreeTable{T}, n_pi::Vector{Float64}) where T
    return graphweight(one_tree) + sum((degrees(degree_table)[i] - 2) * n_pi[i] for i = 1 : length(n_pi))
end

"""Ajoute au poids de chaque arête le coefficient de chacune de ses extrémités."""
function modify_costs!(graph::AbstractGraph, n_pi::Vector{Float64})
    for e in edges(graph)
        weight(e) = weight(e) + n_pi(s_node(e), graph) + n_pi(d_node(e), graph)
    end
end

"""Soustrait au poids de chaque arête le coefficient de chacune de ses extrémités."""
function restore_costs!(graph::AbstractGraph, n_pi::Vector{Float64})
    for e in edges(graph)
        weight(e) = weight(e) - n_pi(s_node(e), graph) - n_pi(d_node(e), graph)
    end
end

"""Renvoie une tournée optimisée passant par tous les points du graphe symétrique
en entrée en utilisant l'algorithme de Held et Karp. La méthode renvoie un objet
de type Graph contenant la meilleure tournée obtenue après "max_iter" itérations.
ATTENTION : dans le graphe en entrée, les noeuds doivent tous avoir un attribut "name" différent.
"""
function HK(graph::AbstractGraph{T}, step::Float64 = 1.0, starting_node::AbstractNode = nodes(graph)[1], max_iter::Int64 = 100, max_gap::Float64 = 0.0) where T
    one_tree = prim(graph, starting_node)
    RSL_tour = RSL(one_tree, graph)
    HK_tour = Graph{T}("HK_tour", [], [])
    degree_table = init_degree_table(graph)
    n_pi = Vector{Float64}(step * ones(length(nodes(graph))))
    w = -Inf
    max_w = w
    max_n_pi = n_pi
    iter = 0
    gap = Inf
    while iter < max_iter && gap > max_gap
        modify_costs!(graph, n_pi)
        one_tree = prim(graph, starting_node)
        HK_tour = RSL(one_tree, graph)
        add_edge!(one_tree, sort(filter(e -> (name(s_node(e)) == name(nodes(graph)[1]) || name(d_node(e)) == name(nodes(graph)[1])) && !(e in edges(one_tree)), edges(graph)), by=weight)[1])
        degree_table = degree_table!(one_tree)
        w = lower_bound(one_tree, degree_table, n_pi)
        if w > max_w
            max_w = w
            println("C : ", graphweight(RSL_tour), " || w : ", w)
            max_n_pi = n_pi
            gap = graphweight(RSL_tour) - max_w
        end
        for i = 1 : length(n_pi)
            n_pi[i] += step * (degrees(degree_table)[i] - 2)
        end
        restore_costs!(graph, n_pi)
        iter += 1
    end
    println("iter : ", iter)
    return HK_tour
end

"""Calcule et affiche la tournée obtenue avec l'algorithme de Prim et la méthode RSL."""
function RSL_total_prim(chemin::String)
     graph = main1(chemin)
     graph_min = prim(graph)
     RSL_tree = RSL(graph_min, graph)
     println(graphweight(RSL_tree))
     plot_graph(RSL_tree)
end

"""Calcule et affiche la tournée obtenue avec l'algorithme de Kruskal et la méthode RSL."""
function RSL_total_kruskal(chemin::String)
     graph = main1(chemin)
     graph_min = kruskal(graph)
     RSL_tree = RSL(graph_min, graph)
     println(graphweight(RSL_tree))
     plot_graph(RSL_tree)
end

"""Calcule et affiche la tournée obtenue avec l'algorithme de Prim et la méthode de Held & Karp."""
function HK_total_prim(chemin::String)
     graph = main1(chemin)
     graph_min = prim(graph)
     HK_tree = HK(graph)
     println(graphweight(HK_tree))
     plot_graph(HK_tree)
end

"""Calcule et affiche la tournée obtenue avec l'algorithme de Kruskal et la méthode de Held & Karp."""
function HK_total_kruskal(chemin::String)
     graph = main1(chemin)
     graph_min = kruskal(graph)
     HK_tree = HK(graph)
     println(graphweight(HK_tree))
     plot_graph(HK_tree)
end
