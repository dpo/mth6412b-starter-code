include("kruskal.jl")
"""Test de l'algorithme kruskal sur toutes les instances stsp. kruskal faisant appel à create_graph, nous pouvons également vérifier
que les tests unitaires associés à create_graph sont toujours validés.
"""
path = "projet\\instances\\stsp\\"
for file in readdir(path)
    graph_file = kruskal(path*file)
    println("Test passé :"*file)
    println(file*"Poids minimal : "*string(poids_total(graph_file)))
end
