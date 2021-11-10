include("prim.jl")

function preordre(graphe::Graph, racine::Node)
    lis_noeuds = [racine]
    lis_edges = find_edges(racine.name,graphe)
    edges_graph = copy(graphe.edges)
    for edge in lis_edges
        if edge.sommet1.name == racine.name
            autre_sommet = edge.sommet2
        else
            autre_sommet = edge.sommet1
        end
        edges2 = filter!(e -> sommets(e) != sommets(edge), edges_graph)
        graph2 = Graph("Graphe fils", graphe.nodes, edges2)
        lis_noeuds = vcat(lis_noeuds, preordre(graph2,autre_sommet))    
    end
    lis_noeuds
end




function rsl(graphe::Graph, racine::Node, algo::String)
    mat_edges = mat_adjacence(graphe)
    copy_graph = Graph(graphe.name,copy(graphe.nodes), copy(graphe.edges))
    if algo == "prim"
        arbre = prim(copy_graph,racine)
    else
        arbre = kruskal(copy_graph)
    end
    lis_noeuds = preordre(arbre,racine)

    T = typeof(racine.data)
    lis_aretes = Edge{T}[]

    for i in 1:length(lis_noeuds)-1
        #println(lis_noeuds[i].name*" "*lis_noeuds[i+1].name)
        push!(lis_aretes, mat_edges[parse(Int, lis_noeuds[i].name), parse(Int, lis_noeuds[i+1].name) ])
    end
    push!(lis_aretes, mat_edges[parse(Int, lis_noeuds[length(lis_noeuds)].name), parse(Int, lis_noeuds[1].name)])


    tournee = Graph("Tour_RSL"*graphe.name, graphe.nodes, lis_aretes)
    tournee
end
function min_rsl(graphe::Graph)
    T = typeof(graphe.nodes[1].data)
    poids_min = Inf
    graph_min = Graph("",Node{T}[],Edge{T}[])
    racine_min = nothing
    for node in graphe.nodes
        racine = node
        graph1 = rsl(graphe,racine,"prim")
        graph2 = rsl(graphe,racine,"kruskal")
        if poids_total(graph1) < poids_min
            graph_min = graph1
            poids_min = poids_total(graph1)
            racine_min = racine
        end
        if poids_total(graph2) < poids_min
            graph_min = graph2
            poids_min = poids_total(graph2)
            racine_min = racine
        end
    end
    graph_min,poids_min,racine_min
end




