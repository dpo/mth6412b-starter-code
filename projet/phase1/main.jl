
include("./read_stsp.jl")

"""" Lis le fichier tsp et en extrait les données
    - Construit l'objet Graph 
    - Construit les objets Nodes (explicites ou implicites)
    - Construit les objets Edges
    
    Retourne le graph associé au fichier donné en argument.
    Si le graphe décrit est representable (ie. les noeuds ont une donnée coordonnées spécifiée), l'image est sauvegardée
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
        #Si le format des donnees est tel que les aretes i-i sont explicitées (edge_weight_format) et le poid d'une telle arete est nul, et c'est bien une arete i-i, alors on ne cré pas l'arete. 
        #Autrement elle est créée et ajoutée au graphe.
        if header["EDGE_WEIGHT_FORMAT"] in ["FULL_MATRIX", "UPPER_DIAG_ROW", "LOWER_DIAG_ROW"] && weights[i]==0 && edges_brut[i][1] == edges_brut[i][2] 
        else
            # Fonction get_node renvoie l'objet Node dans g en fonction de son nom
            u = get_node(g, "$(edges_brut[i][1])")
            v = get_node(g, "$(edges_brut[i][2])")
            edge = Edge{typeof(data(u))}((u,v),weights[i])
            add_edge!(g, edge)
        end
    end
    show(g)
    return g
end


""" 
Pour lancer le programme:
    Se placer dans le dossier projet/phase1
    lancer julia main.jl "Nom de l'instance".tsp 
    exemple:
        julia main.jl gr17.tsp
"""
filename = ARGS[1]
build_graph("../../instances/stsp/$(filename)")