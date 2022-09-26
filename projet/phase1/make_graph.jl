function make_graph(filename::String)
    header = read_header(filename)
    nodes_brut = read_nodes(header, filename)
    edges_brut = read_edges(header, filename)[1]
    weights = read_edges(header, filename)[2]
    nodes=[]
    edges=[]
    for i in nodes_brut
        node = Node(String(i), nodes_brut[i])
        push!(nodes, node)
    end
    for i = 1 : length(edges_brut)
        n1 = Node(String(edges_brut[i][1]), edges_brut[i][1])
        n2 = Node(String(edges_brut[i][2]), edges_brut[i][2])
        edge = Edge((n1, n2), weights[i])
        push!(edges, edge)
    end
    graph = Graph(filename, nodes, edges)
    return graph
end