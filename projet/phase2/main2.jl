include("node.jl")
include("edge.jl")
include("connexe.jl")
include("read_stsp.jl")


function create_graph(filename::String) 
    graph_nodes,graph_edges = read_stsp(filename)

    lis_nodes = Node{Vector{Float64}}[]
    for k =1 : length(graph_nodes)
        push!(lis_nodes,Node{Vector{Float64}}(string(k) , graph_nodes[k]))
    end

    lis_edges = []
    for k =1 : length(graph_edges)
        for l = 1: length(graph_edges[k])
            if graph_edges[k][l][2] != 0                                                               # Les arêtes de poids nuls sont exclues.
             push!(lis_edges, (string(k), string(graph_edges[k][l][1]) , graph_edges[k][l][2] ))  
            end 
        end
    end
    lis_edges
    sort!(lis_edges, by = x -> x[3]); lis_edges                 # On tris les arêtes par ordre croissant de poids. 
     
    #Connex(filename, lis_nodes, lis_edges)
end


