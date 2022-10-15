include("node.jl")
include("edge.jl")
include("read_stsp.jl")
include("make_graph.jl")
include("graph.jl")
include("kruskal.jl")


function main(filename::String)
    graph = make_graph(filename)
    kruskal(graph)
end
