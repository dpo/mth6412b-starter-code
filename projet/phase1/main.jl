include("graph.jl")
include("read_stsp.jl")

function read_graph_stsp(filename::String)
    # Read input file
    header = read_header(filename)
    _nodes, _edges = read_stsp(filename)

    # Create the graph
    T = valtype(_nodes)
    g = Graph{T}(header["NAME"], Node{T}[], Edge{T}[])
    
    # Create the nodes
    N = length(_edges)  # Number of nodes
    if length(_nodes) == 0
        show(filename)
        # Nodes do not have any data
        for i in 1:N
            node = Node{T}("$i", T(), i)
            add_node!(g, node)
        end
    else
        # Node have data associated
        for i in 1:N
            node = Node{T}("$i", _nodes[i], i)
            add_node!(g, node)
        end
    end

    # Create the edges
    for (i, edges) in enumerate(_edges)
        # i is on extremity of the node
        for (j, w) in edges
            e = Edge{T}((i, j), w)
            add_edge!(g, e)
        end
    end

    return g
end

# List of stsp instances
const STSP_DIR = "../instances/stsp/"
const STSP = readdir(STSP_DIR)
const GRAPHS = [read_graph_stsp(joinpath(STSP_DIR, graph)) for graph in STSP]
