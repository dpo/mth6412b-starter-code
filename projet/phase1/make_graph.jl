function make_graph(filename::String)
    header = read_header(filename)
    nodes_brut = read_nodes(header, filename)
    edges_brut = read_edges(header, filename)[1]
    weights = read_edges(header, filename)[2]
    nodes=Vector{Node}(undef, length(nodes_brut))
    edges=Vector{Edge}(undef, length(edges_brut))
    j = 1
    for k in keys(nodes_brut)
        node = Node(string(k), nodes_brut[k])
        nodes[j] = node
        j = j + 1
    end
    for i = 1 : length(edges_brut)
        n1 = Node(string(edges_brut[i][1]), nodes_brut[edges_brut[i][1]])
        n2 = Node(string(edges_brut[i][2]), nodes_brut[edges_brut[i][2]])
        edge = Edge((n1, n2), weights[i])
        edges[i] = edge
    end
    graph = Graph(filename, nodes, edges)
    return graph
end