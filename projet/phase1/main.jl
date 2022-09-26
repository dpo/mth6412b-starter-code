include("node.jl")
include("edge.jl")
include("read_stsp.jl")
include("make_graph.jl")
include("graph.jl")


function main(filename::String)
    graph = make_graph("instances/stsp/bayg29.tsp")
end
