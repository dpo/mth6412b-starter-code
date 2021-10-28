include("prim.jl")
using Test
"""Test de l'algorithme kruskal sur toutes les instances stsp. kruskal faisant appel à create_graph, nous pouvons également vérifier
que les tests unitaires associés à create_graph sont toujours validés.
"""
path = "projet\\instances\\stsp\\"
for file in readdir(path)
    graph_file = kruskal(path*file)
    graph_file2 = prim(path*file)

    @test poids_total(graph_file)==poids_total(graph_file2) 

    #On teste que les deux algorithmes renvoient le même poids qui est très probablement le poids minimal

    println("Test passé :"*file)
    println(file*"Poids minimal : "*string(poids_total(graph_file)))
end
