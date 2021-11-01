include("mainphase2.jl")
include("projet/phase3/nodequeue.jl")
include("projet/phase3/tools.jl")

"""
Heuristique union via le rang qui prend deux composantes.
Modifie la première composante connexe en argument.
"""
function unionRang!(comp1::ConnexComp{T}, comp2::ConnexComp{T}) where{T}
    # Trouver les racines de chaque composante connexe
    currentnode = nodes(comp1)[1]
    while parent(currentnode) !== nothing
        currentnode = parent(currentnode)
    end
    racine1 = currentnode
    currentnode = nodes(comp2)[1]
    while parent(currentnode) !== nothing
        currentnode = parent(currentnode)
    end
    racine2 = currentnode

    # Union des composantes
    if rank(racine1) == rank(racine2)
        racine1.rank += 1
        racine2.parent = racine1
    elseif rank(racine1) > rank(racine2)
        racine2.parent = racine1
    else
        racine1.parent = racine2
    end
    append!(nodes(comp1), nodes(comp2))
 
    # Compression des chemins
    if rank(racine1) < rank(racine2)
        compressionsChemins!(comp1, nodes(comp1)[1], racine2)
    else
        compressionsChemins!(comp1, nodes(comp1)[1], racine1)
    end
    return
end

"""
Heuristique de compression des chemins sur une composante connexe triée par rang croissant.
"""
function compressionsChemins!(comp::ConnexComp{T}, start::Node{T}, racine::Node{T}) where{T}
    # Change les liens de parenté
    currentNode = start
    while parent(currentNode) !== nothing
        nextpath = currentNode.parent
        currentNode.parent = racine
        currentNode = nextpath
    end

    # Trouver le rang de la racine
    h = 0
    for node in nodes(comp)
        if rank(node) == 0
            lower_h = 0
            currentNode = node
            while parent(currentNode) !== nothing
                lower_h += 1
                currentNode = parent(currentNode)
            end
            h = max(h, lower_h)
        end
        node.rank = 0
    end

    # Mettre à jour le rang de la racine
    racine.rank = h
    #while #il y a au moins un sommet de rang -1
    #    for node in nodes(comp)
    #        if (rank(parent(node)) != -1) && (rank(node) == -1)
    #            node.rank =  rank(parent(node)) - écart entre node et parent dans graphe d'origine
    #        end
    #    end
    #end
    return
end

"""
Focntion kruskal de la phase2 accélérée en utilisant l'union via le rang.
"""
function kruskal_acc(graph::Graph{T, I}) where{T, I}
    # Trier les arêtes du graphe en ordre croissant de poids.
    sort!(graph.edges)

    #Initialisation de l'arbre de coût minimum
    #et de SC le vecteur des S, où S est une composante connexe de G.
    arbre = Vector{Union{Nothing, Edge{T, I}}}(nothing, nb_nodes(graph) - 1)
    j = 0
    SC = [ConnexComp(Node{T}[node]) for node in nodes(graph)]

    comp = [0, 0]
    for edge in edges(graph)
        si = edge.data[1]
        sj = edge.data[2]
        comp .= 0
        for i in 1:length(SC)

            #Pour chaque arête [si, sj], on place l'indice par rapport à SC de la composante connexe contenant 
            #si et l'indice de sj dans la liste comp.
            for s in nodes(SC[i])
                if s == si
                    comp[1] = i
                elseif s == sj
                    comp[2] = i
                end
            end
        end

        #Si sj et si sont dans des composantes distinctes, on ajoute l'arète à l'arbre
        #et on fusionne les deux composantes connexes.
        if comp[1] != comp[2]
            j += 1
            arbre[j] = edge
            unionRang!(SC[comp[1]], SC[comp[2]])
            deleteat!(SC, comp[2])
        end
    end
    arbre
end

"""
Applique l'algorithme de Prim sur un graphe. Ne renvoie rien.
"""
function prim!(graph::Graph{T, I}, s::Node{T}) where{T, I}
    s.min_weight = 0

    #Initialisation d'une file de sommets de priorité
    file = NodeQueue([node for node in nodes(graph)])
    while !(is_empty(file))

        #t est le sommet de plus haute priorité, i.e. dont le champ min_weight est le plus bas
        t = popfirst!(file)
        for edge in edges(graph)
            e1 = data(edge)[1]
            e2 = data(edge)[2]
            uinfile = false

            #u est un sommet adjacent à t qui est dans la file
            if e1 == t && isinfile(file, e2)
                u = e2
                uinfile = true
            elseif e2 == t && isinfile(file, e1)
                u = e1
                uinfile = true
            end

            #Si l'arête enter t et u à un cout plus petit que u, mise à jour du cout et du parent
            if uinfile && weight(edge) <= min_weight(u)
                u.parent = t
                u.min_weight = weight(edge)
            end
        end
    end
    return
end

"""
Vérifie si node est dans la file de sommets file.
"""
function isinfile(file::NodeQueue{T}, node::Node{T}) where T
    for item in file.items
        if item == node
            return true
        end
    end
    return false
end

#Création d'exemples pour tester les heuristiques
s1 = Node("s1", [0, 0], 1, 0.0, nothing)
s2 = Node("s2", [0, 0], 0, 0.0, s1)
s3 = Node("s3", [0, 0], 0, 0.0, s1)
compEx1 = ConnexComp([s1, s2, s3], "compEx1")
s4 = Node("s4", [0, 0], 1, 0.0, nothing)
s5 = Node("s5", [0, 0], 0, 0.0, s4)
compEx2 = ConnexComp([s4, s5], "compEx2")
s6 = Node("s6", [0, 0], 2, 0.0, nothing)
s7 = Node("s7", [0, 0], 1, 0.0, s6)
s8 = Node("s8", [0, 0], 0, 0.0, s7)
compEx3 = ConnexComp([s6, s7, s8], "compEx3")
n5 = Node("5", [0,0], 4, 0.0, nothing)
n4 = Node("4", [0,0], 3, 0.0, n5)
n8 = Node("8", [0,0], 3, 0.0, n5)
n9 = Node("9", [0,0], 2, 0.0, n4)
n0 = Node("0", [0,0], 2, 0.0, n4)
n3 = Node("3", [0,0], 2, 0.0, n8)
n1 = Node("1", [0,0], 2, 0.0, n8)
n7 = Node("7", [0,0], 1, 0.0, n3)
n6 = Node("6", [0,0], 1, 0.0, n3)
n2 = Node("2", [0,0], 0, 0.0, n6)
n10 = Node("10", [0,0], 0, 0.0, n6)
n11 = Node("11", [0,0], 2, 0.0, n5)
compEx4 = ConnexComp([n5, n4, n8, n9, n0, n3, n1, n7, n6, n2, n10, n11], "compEx4")
solution_parents_compEx4 = [n4, n8, n6, n5, n5, nothing, n5, n3, n5, n4, n6, n5]

"""
Teste la fonciton unionRang() sur des exemples.
"""
function test_unionRang(comp1::ConnexComp{T}, comp2::ConnexComp{T}) where{T}
    currentnode = nodes(comp1)[1]
    while parent(currentnode) !== nothing
        currentnode = parent(currentnode)
    end
    racine1 = deepcopy(currentnode)
    currentnode = nodes(comp2)[1]
    while parent(currentnode) !== nothing
        currentnode = parent(currentnode)
    end
    racine2 = deepcopy(currentnode)

    unionRang!(comp1, comp2)
    currentnode = nodes(comp1)[1]
    while parent(currentnode) !== nothing
        currentnode = parent(currentnode)
    end
    newracine1 = currentnode

    @test (rank(newracine1) == rank(racine1) + 1) || (
           rank(newracine1) == rank(racine2) + 1)
    @test name(newracine1) == name(racine1) || name(newracine1) == name(racine2)
    @test parent(newracine1) === nothing
    println("Union de $(name(comp1)) et $(name(comp2)) ✓")
end

"""
Teste la fonction compressionsChemins() sur une composante connexe en connaissant la solution
"""
function test_compression(comp::ConnexComp, solution_parents::Vector{Union{Nothing, Node{T}}}, start::Node{T}) where T
    currentnode = nodes(comp)[1]
    while parent(currentnode) !== nothing
        currentnode = parent(currentnode)
    end
    racine = currentnode
    compressionsChemins!(comp, start, racine)
    for node in nodes(comp)
        @test solution_parents[parse(Int, name(node))+1] == parent(node)
    end
    println("$(name(comp)) ✓")
end

"""
Teste la fonction prim! sur tous les fichiers .tsp.
"""
function test_prim_all(path, prim_func)
    for file_name in readdir(path)
		if file_name[end-3:end] == ".tsp"  && file_name != "pa561.tsp"

            graph = createGraph(string(file_name), string(path, "/", file_name))
            prim_func(graph, nodes(graph)[1])
            i = 0
            for node in nodes(graph)
                i += 1
                if name(node) == name(nodes(graph)[1])
                    @test parent(node) === nothing
                else
                    @test parent(node) !== nothing
                end
            end
            println(file_name, "✓\tcout min: ", sommeweights(graph))

        end
    end
end

"""
Teste une fonction prim sur le graphe en exemple du cours.
"""
function test_prim(graph::Graph{T, I}, s::Node{T}, prim_func) where{T, I}
    prim_func(graph, s)
    sum = 0
    i = 0
    solution1 = [nothing, a, b, c, d, c, f, g, c]
    solution2 = [nothing, a, f, c, d, g, h, a, c]
    solution = Vector{Union{Nothing, Node{T}}}(nothing, 9)
    for node in nodes(graph)
        sum += min_weight(node)
        i += 1
        solution[i] = parent(node)
    end
    @test solution == solution1 || solution == solution2
    @test sum == 37
    println("G exemple du cours ✓")
end

using PrettyTables

"""
Affiche un tableau des résultats des benchmarks entre les algorithmes de Prim, Kruskal et Kruskal accéléré. 
"""
function benchmark_table_KruskalPrim(path)
    data = zeros(length(readdir(path)), 3)
    row_names = []
    i = 1
    for file_name in readdir(path)
		if file_name[end-3:end] == ".tsp"  #&& file_name != "pa561.tsp"
            graph1 = createGraph(string(file_name), string(path, "/", file_name))
            graph2 = deepcopy(graph1)
            graph3 = deepcopy(graph1)
            t1 = @timed prim!(graph1, nodes(graph1)[1])
            t2 = @timed kruskal(graph2)
            t3 = @timed kruskal_acc(graph3)
            data[i, 1] = t1.time
            data[i, 2] = t2.time
            data[i, 3] = t3.time
            i += 1
            push!(row_names, file_name[1:end-4])
        end
    end
    header = ["prim!", "kruskal", "kruskal_acc"]
    pretty_table(data; 
                 header = header,
                 row_names= row_names,
                 title = "Comparaison des performances entre les algorithmes implémentés",
                 formatters = ft_printf("%5.2e"))
end

#Les lignes qui suivent sont exécutées en démonstration dans le fichier Pluto.

#test_unionRang(deepcopy(compEx1), deepcopy(compEx2))
#test_unionRang(deepcopy(compEx1), deepcopy(compEx3))
#test_unionRang(deepcopy(compEx2), deepcopy(compEx3))

#test_compression(compEx4, solution_parents_compEx4, n6)

#arbrecoutmin = kruskal(Gexcours)
#for e in arbrecoutmin
#    show(e)
#end
#@test nothing ∉ arbrecoutmin
#@test sommeweights(arbrecoutmin) == 37
#println("G exemple du cours ✓")

#test_kruskal("mth6412b-starter-code/instances/stsp", kruskal_acc)

#test_prim(Gexcours, a, prim!)
#for node in nodes(Gexcours)
#    show(node)
#end
#test_prim_all("mth6412b-starter-code/instances/stsp", prim!)

#benchmark_table_KruskalPrim("mth6412b-starter-code/instances/stsp")
