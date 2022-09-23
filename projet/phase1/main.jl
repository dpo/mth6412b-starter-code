
include("graph.jl")
include("read_stsp.jl")



function build_graph(filename::String)
    graph_nodes, graph_edges, edges_brut = read_stsp(filename)
    @show graph_nodes
    header = read_header(filename)
    T = NaN
    if header["DISPLAY_DATA_TYPE"] == "TWOD_DISPLAY" || header["DISPLAY_DATA_TYPE"] == "COORD_DISPLAY"
        T = Vector{Float16}
    end
    @show T
    g = Graph{T}("Mon graphe", Vector{Node}(), Vector{Edge}())

    if header["DISPLAY_DATA_TYPE"] == "TWOD_DISPLAY" || header["DISPLAY_DATA_TYPE"] == "COORD_DISPLAY"
        @show "Here"
        plot_graph(graph_nodes, graph_edges)

        for n in 1:length(graph_nodes)
            @show n, graph_nodes[n]
            node = Node("$(n)", graph_nodes[n])
            add_node!(g, node)
        end
end
    show(g)
    edges = []
    for e in edges_brut
        #push!(edges, Edge(e[1], e[2]))
    end
        return g
end


filename = "./instances/stsp/brg180.tsp"##ARGS[1]


g = build_graph(filename)