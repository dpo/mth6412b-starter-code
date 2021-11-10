include("rsl.jl")
using Test

path = joinpath("projet", "instances", "stsp")
for file in readdir(path)
    if file != "brg180.tsp"

        println(file*":")
        println(" ")

        arbre,poids,noeud = min_rsl(create_graph(joinpath(path,file)))
        println(" ")

        println("Le poids minimal obtenu est de"*string(poids))
    end
end