
"""" Lis le fichier tsp et en extrait les données

    - Construit les objets noeuds (explicites ou implicites)
    - Construit les objets edges
    - Construit l'objet graph 

    retourne le graph du fichier donné en argument
"""

include("./read_stsp.jl")
function build_graph(filename::String)
    graph_nodes, graph_edges, edges_brut, weights = read_stsp(filename)
    header = read_header(filename)

    ### Construire les nodes
    if header["DISPLAY_DATA_TYPE"] == "TWOD_DISPLAY" || header["DISPLAY_DATA_TYPE"] == "COORD_DISPLAY"
        g = Graph{Vector{Float64}}("Mon graphe", Vector{Node}(), Vector{Edge}())
        plot_graph(graph_nodes, graph_edges)
        for n in keys(graph_nodes)
            add_node!(g, Node("$(n)", graph_nodes[n]))
        end
    else
        g = Graph{Nothing}("Mon graphe", Vector{Node}(), Vector{Edge}())
        for i in 1:parse(Int, header["DIMENSION"])
            add_node!(g, Node("$(i)", nothing))
        end
    end


    ### Construire les edges 
    g_nodes = nodes(g)
    for i in eachindex(edges_brut)
        u = get_node(g, "$(edges_brut[i][1])")
        v = get_node(g, "$(edges_brut[i][2])")
        edge = Edge{typeof(data(u))}((u,v),weights[i])
        add_edge!(g, edge)
    end
    show(g)
    return g
end





filename = "./instances/stsp/gr17.tsp"
build_graph(filename)