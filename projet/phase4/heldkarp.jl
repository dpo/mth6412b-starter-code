include("prim.jl")

function min1tree(graph::Graph,racine::Node)
    lis_nodes = copy(graph.nodes)
    lis_edges = copy(graph.edges)
    filter!(n -> n.name!= racine.name, lis_nodes)
    aretes_racine = find_edges(racine.name,graph)
    filter!(e -> e.sommet1.name != racine.name && e.sommet2.name != racine.name, lis_edges)
    mst = prim(Graph(graph.name,lis_nodes,lis_edges))

    min1 = Inf
    min2 = Inf
    edge1 = nothing
    edge2 = nothing
    for edge in aretes_racine
        if poids(edge) < min1
            edge2 = edge1
            min2 = min1
            edge1 = edge
            min1 = poids(edge)
        elseif poids(edge) < min2
            edge2 = edge
            min2 = poids(edge)
        end
    end
    push!(mst.edges, edge1)
    push!(mst.edges, edge2)
    push!(mst.nodes, racine)
    mst
end

function degrees(graph::Graph)
    d = zeros(length(graph.nodes))
    for edge in graph.edges
        d[parse(Int, edge.sommet1.name)] += 1
        d[parse(Int, edge.sommet2.name)] += 1
    end
    d
end

function heldkarp(graph::Graph, racine::Node, step_size::Float64,nb_iter::Int)
    T = typeof(racine.data)
    k = 0
    Pi = zeros(length(graph.nodes))
    W = -Inf
    d = zeros(length(graph.nodes))
    v = d.-2
    graph_modifie = Graph(graph.name,copy(graph.nodes),copy(graph.edges))
    min1_tree = min1tree(graph_modifie,racine)
    step_effectif = step_size

    while v != zeros(length(graph.nodes)) && k <= nb_iter
        min_1tree = min1tree(graph_modifie,racine)
        wk = poids_total(min_1tree) - 2*sum(Pi)
        W = max(W,wk)
        d = degrees(min_1tree)
        v = d.-2
        if k<= nb_iter/10
            step_effectif = 100*step_size
        elseif k <= nb_iter/2
            step_effectif = 10*step_size
        else 
            step_effectif = step_size
        end

        Pi = Pi + step_effectif * v
        lis_edges = Edge{T}[]
        for edge in graph_modifie.edges
            push!(lis_edges, Edge(edge.sommet1, edge.sommet2, edge.poids +  step_size*v[parse(Int, edge.sommet1.name)] + step_size*v[parse(Int, edge.sommet2.name)]))
        end
        graph_modifie= Graph(graph_modifie.name,graph_modifie.nodes,lis_edges)
        k += 1
        if k%(nb_iter//10) == 0
            println(W)
        end

    end
    min1_tree,W
end

function test_hk(graphe::Graph,step_size::Float64,nb_iter::Int)  
    poids_max = -Inf
    T = typeof(graphe.nodes[1].data)
    graph_max = Graph("",Node{T}[],Edge{T}[])

    for node in graphe.nodes
        arbre,poids_arbre = heldkarp(graphe,node,step_size,nb_iter)
        """if poids_arbre > poids_max
            graph_max = arbre
            poids_max = poids_arbre
        end"""
        println(node.name* " : "*string(poids_arbre))
    end
end
