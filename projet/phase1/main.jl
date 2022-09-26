
include("./read_stsp.jl")
"""" Lis le fichier tsp et en extrait les données
    - Construit l'objet Graph 
    - Construit les objets Nodes (explicites ou implicites)
    - Construit les objets Edges
    
    Retourne le graph associé au fichier donné en argument.
"""

function build_graph(filename::String)
    graph_nodes, graph_edges, edges_brut, weights = read_stsp(filename)
    header = read_header(filename)

    ### Construire les nodes
    if header["DISPLAY_DATA_TYPE"] == "TWOD_DISPLAY" || header["DISPLAY_DATA_TYPE"] == "COORD_DISPLAY"
        g = Graph{Vector{Float64}}("Mon graphe", Vector{Node}(), Vector{Edge}())
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
        if weights[i] != 0
            u = get_node(g, "$(edges_brut[i][1])")
            v = get_node(g, "$(edges_brut[i][2])")
            edge = Edge{typeof(data(u))}((u,v),weights[i])
            add_edge!(g, edge)
        end
    end
    show(g)
    return g
end





filename = "./instances/stsp/dantzig42.tsp"
build_graph(filename)