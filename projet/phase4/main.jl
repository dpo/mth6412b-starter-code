
using Pkg
Pkg.activate(joinpath(@__DIR__, "mth6412b/"))
using Test
import Base.show
using Plots
using LinearAlgebra

include(joinpath(@__DIR__, "exceptions.jl"))
include(joinpath(@__DIR__, "node.jl"))
include(joinpath(@__DIR__, "edge.jl"))
include(joinpath(@__DIR__, "graph.jl"))
include(joinpath(@__DIR__, "connected_component.jl"))
include(joinpath(@__DIR__, "heuristics.jl"))
include(joinpath(@__DIR__, "kruskal.jl"))
include(joinpath(@__DIR__, "prim.jl"))
include(joinpath(@__DIR__, "tree.jl"))
include(joinpath(@__DIR__, "RSL.jl"))
include(joinpath(@__DIR__, "HK.jl"))

println("Make sure you are running this file from the phase4 folder!")
println("Choose a symmetric instance (only the filename): ")

filename = readline()
filepath = joinpath(@__DIR__, "..","..","instances", "stsp", filename)
graph = build_graph(filepath)

best_rsl_graph, best_rsl_graph_weight = rsl(graph, nodes(graph)[1]; is_kruskal = true)
best_params = Dict(:root_vertex => nodes(graph)[1], :is_kruskal => false)
for node in nodes(graph)[1:10]
    for i in 0:1
        rsl_graph, rsl_graph_weight = rsl(graph, node; is_kruskal = Bool(i))
        if best_rsl_graph_weight > rsl_graph_weight
            global best_rsl_graph_weight = rsl_graph_weight
            global best_rsl_graph = rsl_graph
            best_params[:root_vertex] = node
            best_params[:is_kruskal] = Bool(i)
        end
    end
end
println("rsl done ✔")

@enum Version slow_convergence = 1 lin_kernighan = 2 
best_hk_graph, best_hk_graph_weight = hk(graph; is_kruskal = false, step_size_0 = 1.0, ϵ = 10^-5)
best_params = Dict(:is_kruskal => false, :step_size_0 => 1.0, :ϵ => 1*10^-5)
for epsilon in [10^-5, 10^-7, 10^-9]
    for step_size in [1.0, 5.0, 16.0] 
        for i in 0:1
            hk_graph, hk_graph_weight = hk(graph; is_kruskal = Bool(i), step_size_0 = step_size, ϵ = epsilon)
            if best_hk_graph_weight < hk_graph_weight
                global best_hk_graph_weight = hk_graph_weight
                global best_hk_graph = hk_graph
                best_params[:step_size_0] = step_size
                best_params[:is_kruskal] = Bool(i)
                best_params[:ϵ]=epsilon
            end
        end
    end
end

println("hk done ✔")
optimal_tour_weight = 0
open(joinpath(@__DIR__, "..","..","instances", "solutions_stsp.txt"), "r") do f
    for line in eachline(f)
        line = strip(line)
        file_data = split(line, ":")
        if strip(file_data[1]) == split(filename, ".")[1]
            global optimal_tour_weight = parse(Int64, strip(file_data[2]))
            break
        end
    end
end


rsl_relative_error = round(abs(optimal_tour_weight-best_rsl_graph_weight)/optimal_tour_weight; digits = 2)
hk_relative_error = round(abs(optimal_tour_weight-best_hk_graph_weight)/optimal_tour_weight; digits = 2)


println("best rsl graph weight: $(best_rsl_graph_weight)")
println("best hk graph weight: $(best_hk_graph_weight)")
println("optimal tour: ",  optimal_tour_weight)
println("rsl_relative_error: ", rsl_relative_error)
println("hk_relative_error: ", hk_relative_error)

[plot_graph(best_graph) for best_graph in (best_rsl_graph, best_hk_graph)]