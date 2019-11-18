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

"""Renvoie la valeur du coefficient d'un noeud selon la table n_pi en entrée."""
function coef(coefs::Vector{Float64}, node::AbstractNode, nodes::Vector{Node{T}}) where T
    i = findfirst(n -> name(n) == name(node), nodes)
    coefs[i]
end

"""Calcule et renvoie la borne inférieure "w" que l'algorithme de Held et Karp cherche à maximiser."""
function lower_bound(one_tree::AbstractGraph{T}, degree_table::AbstractDegreeTable{T}, n_pi::Vector{Float64}) where T
    return graphweight(one_tree) + sum((degrees(degree_table)[i] - 2) * n_pi[i] for i = 1 : length(n_pi))
end

"""Ajoute au poids de chaque arête le coefficient de chacune de ses extrémités."""
function modify_costs!(graph::AbstractGraph, n_pi::Vector{Float64})
    for edge in edges(graph)
        set_weight!(edge, weight(edge) + coef(n_pi, s_node(edge), nodes(graph)) + coef(n_pi, d_node(edge), nodes(graph)))
    end
end

"""Soustrait au poids de chaque arête le coefficient de chacune de ses extrémités."""
function restore_costs!(graph::AbstractGraph, n_pi::Vector{Float64})
    for edge in edges(graph)
        set_weight!(edge, weight(edge) - coef(n_pi, s_node(edge), nodes(graph)) - coef(n_pi, d_node(edge), nodes(graph)))
    end
end

"""Renvoie une tournée optimisée passant par tous les points du graphe symétrique
en entrée en utilisant l'algorithme de Held et Karp. La méthode renvoie un objet
de type Graph contenant la meilleure tournée obtenue après "max_iter" itérations.
ATTENTION : dans le graphe en entrée, les noeuds doivent tous avoir un attribut "name" différent.
"""
function HK(graph::AbstractGraph{T}, step::Float64 = 2.0, starting_node::AbstractNode = nodes(graph)[1], max_iter::Int64 = 20, max_gap::Float64 = 0.0) where T
    one_tree = prim(graph, starting_node)
    ref_tour = RSL(one_tree, graph)
    # ref_tour = graph
    HK_tour = Graph{T}("HK_tour", [], [])
    min_tour = ref_tour
    degree_table = init_degree_table(graph)
    n_pi = Vector{Float64}(10 * step * ones(length(nodes(graph))))
    w = -Inf
    max_w = w
    max_n_pi = n_pi
    iter = 0
    gap = Inf
    while iter < max_iter && gap > max_gap
        modify_costs!(graph, n_pi)
        one_tree = prim(graph, starting_node)
        # weights1 = [weight(edge) for edge in filter(e -> name(s_node(e)) in name.(s_node.(edges(one_tree))) && name(d_node(e)) in name.(s_node.(edges(one_tree))), edges(graph))]
        # weights2 = weight.(edges(one_tree))
        # for i = 1 : length(edges(one_tree))
        #     println("diff : ", weights2[i] - weights1[i])
        # end
        HK_tour = RSL(one_tree, graph)
        new_edge = sort(filter(e -> (name(s_node(e)) == name(nodes(graph)[1]) || name(d_node(e)) == name(nodes(graph)[1])) && !(e in edges(one_tree)), edges(graph)), by=weight)[1]
        add_edge!(one_tree, Edge{T}(name(new_edge), s_node(new_edge), d_node(new_edge), weight(new_edge)))
        degree_table = degree_table!(one_tree)
        # println("\n", degrees(degree_table))
        restore_costs!(graph, n_pi)
        restore_costs!(one_tree, n_pi)
        restore_costs!(HK_tour, n_pi)
        w = lower_bound(one_tree, degree_table, n_pi)
        # println(n_pi)
        # println("C* : ", graphweight(ref_tour), " || w : ", w, " || weight(1-tree) : ", graphweight(one_tree), " || sum(...) : ", sum((degrees(degree_table)[i] - 2) * n_pi[i] for i = 1 : length(n_pi)))
        # println("weights1 : ", weight.(edges(one_tree)))
        if w > max_w
            max_w = w
            max_n_pi = n_pi
            min_tour = HK_tour
            gap = graphweight(ref_tour) - max_w
        end
        for i = 1 : length(n_pi)
            n_pi[i] += step * (degrees(degree_table)[i] - 2)
        end
        iter += 1
    end
    # println("iter : ", iter)
    # println("max_w : ", max_w)
    return min_tour
end

"""Calcule et affiche la tournée obtenue avec l'algorithme de Prim et la méthode RSL."""
function RSL_total_prim(chemin::String)
     graph = main1(chemin)
     graph_min = prim(graph)
     RSL_tree = RSL(graph_min, graph)
     plot_graph(RSL_tree)
end

"""Calcule et affiche la tournée obtenue avec l'algorithme de Kruskal et la méthode RSL."""
function RSL_total_kruskal(chemin::String)
     graph = main1(chemin)
     graph_min = kruskal(graph)
     RSL_tree = RSL(graph_min, graph)
     plot_graph(RSL_tree)
end

"""Calcule et affiche la tournée obtenue avec l'algorithme de Prim et la méthode de Held & Karp."""
function HK_total_prim(chemin::String)
     graph = main1(chemin)
     graph_min = prim(graph)
     HK_tree = HK(graph)
     plot_graph(HK_tree)
end

"""Calcule et affiche la tournée obtenue avec l'algorithme de Kruskal et la méthode de Held & Karp."""
function HK_total_kruskal(chemin::String)
     graph = main1(chemin)
     graph_min = kruskal(graph)
     HK_tree = HK(graph)
     plot_graph(HK_tree)
end
