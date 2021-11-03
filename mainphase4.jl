include("mainphase3.jl")
using Printf
using Base.Sort

"""
Ne trie que les n plus petits éléments de a
"""
function smallestn!(a, n)
  sort!(a; alg=Sort.PartialQuickSort(n))[1:n]
end

"""
Initialise les listes de voisinages des sommets du graphe.
"""
function initvoisins!(graph::Graph{T, I}) where{T, I}
    for edge in edges(graph)
        add_voisins!(edge)
    end
end

"""
Remplit les listes d'enfants à partir des attributs parent.
"""
function set_enfants!(graph::Graph{T, I}; reset::Bool=false) where{T, I}
    for node in nodes(graph)
        !(reset) && resize!(node.enfants, 0)
        (parent(node) !== nothing) && (add_enfant!(node.parent, node))
    end
end

"""
Applique l'algorithme de Prim accéléré sur un graphe. Ne renvoie rien.
"""
function prim_acc!(graph::Graph{T, I}, s::Node{T}; initialisedvoisins=false) where{T, I}
    s.min_weight = 0
    (initialisedvoisins) || (initvoisins!(graph))

    #Initialisation d'une file de sommets de priorité
    file = NodeQueue([node for node in nodes(graph)])
    while !(is_empty(file))

        #t est le sommet de plus haute priorité, i.e. dont le champ min_weight est le plus bas
        t = popfirst!(file)
        for (u,weightu) in voisins(t)

            #Si l'arête entre t et u à un cout plus petit que u, mise à jour du cout et du parent
            if isinfile(file, u) && weightu <= min_weight(u)
                u.parent = t
                u.min_weight = weightu
            end
        end
    end
    return
end

"""
Renvoie une liste des sommets du graphe parcourus en préordre dans l'arbre de cout minimum.
"""
function parcours_preordre!(node::Node{T}, orderednodes::Vector{Node{T}}) where {T}
    push!(orderednodes, node)
    (length(enfants(node)) == 0) && (return)
    for enfant in enfants(node)
        parcours_preordre!(enfant, orderednodes)
    end
end

"""
Effectue l'algorithme de RSL en réordonnant les nodes d'un graph dans l'ordre de la tournée.
"""
function rsl!(graph::Graph{T, I}, r::Node{T}) where {T, I}
    prim_acc!(graph, r)
    set_enfants!(graph)

    orderednodes = Node{T}[]
    parcours_preordre!(r, orderednodes)
    graph.nodes = orderednodes
end

"""
Retire un sommet et toutes les arêtes qui le contiennent à un graphe
"""
function removeNodeGraph!(graph::Graph{T, I}, s::Node{T}) where {T, I}
    edgesToDel = zeros(Int, nb_nodes(graph)-1)
    j = 0
    for i in 1:nb_edges(graph)
        if data(edges(graph)[i])[1] == s || data(edges(graph)[i])[2] == s
            j += 1
            edgesToDel[j] = i
        end
    end
    filter!(e->e≠ s , nodes(graph))
    print(length(edgesToDel))
    println(edgesToDel)
    return deleteat!(edges(graph), edgesToDel)
end

"""
Effectue une transformation π sur un les poids des arêtes d'un graphe.
"""
function πtransfo!(graph::Graph{T, I}, π::Vector{Float64}) where {T, I}
    for i in 1:nb_nodes(graph)
        nodes(graph)[i].π = π[i]
    end
    for edge in edges(graph)
        edge.weight += (data(edge)[1].π + data(edge)[2].π)
    end
end

"""
Construit un one-tree par les attributs enfants des sommets du graphe
"""
function onetree!(graph::Graph{T, I}, removedEdges::Vector{Edge{T, I}}, removedNode::Node{T}) where {T, I}
    for edge in removedEdges
        add_edge!(graph, edge)
    end
    #ajouter le sommet 1 du 1-tree dans les enfants des deux arêtes de plus petit cout
    minEdge = smallestn!(removedEdges, 2)
    if data(minEdge[1])[1] == removedNode
        push!(enfants(data(minEdge[1])[2]), removedNode)
    elseif data(minEdge[1])[2] == removedNode
        push!(enfants(data(minEdge[1])[1]), removedNode) 
    end
    if data(minEdge[2])[1] == removedNode
        push!(enfants(data(minEdge[2])[2]), removedNode)
    elseif data(minEdge[2])[2] == removedNode
        push!(enfants(data(minEdge[2])[1]), removedNode) 
    end
end

"""
Calcule la somme des poids sur les arêtes d'un onetree.
"""
function LTπ(graph::Graph{T, I}) where {T, I}
    LT = zero(I)
    for edge in edges(graph)
        if data(edge)[1] ∈ enfants(data(edge)[2]) || data(edge)[2] ∈ enfants(data(edge)[1])
            LT += weight(edge)
        end
    end
    return LT
end

"""
Écrit dans le vecteur d les degrés des sommets d'un 1-tree.
"""
function degrees!(d::Vector{Int}, graph::Graph{T, I}, onenode::Node{T}) where {T, I}
    for i in 1:nb_nodes(graph)
        node = nodes(graph)[i]
        if node == onenode
            d[i] = 2
        else
            d[i] = length(enfants(node))
            if parent(node) !== nothing
                d[i] += 1
            end
        end
    end
end

        

function hk!(graph::Graph{T, I}, r::Node{T}; t::Function=k->1/k, maxiter::Int=nb_nodes(graph)) where {T, I}
    if nb_nodes(graph) <= 1
        return  nodes(graph)
    elseif nb_nodes == 2
        nodes(graph)[1].parent = nodes(graph)[2]
        nodes(graph)[2].parent = nodes(graph)[1]
        return nodes(graph)
    end

    k = 1
    W = -Inf
    π = zeros(Float64, nb_nodes(graph))
    Δπ = zeros(Float64, nb_nodes(graph))
    v = ones(Int, nb_nodes(graph))
    stopcriterion = false

    while !(all(v .== 0) || stopcriterion)
        #trouver arboresence minimale avec un node retiré
        πtransfo!(gtest, Δπ)
        removedNode = nodes(graph)[1]
        removedNode.parent = nothing
        removedEdges = removeNodeGraph!(graph, removedNode)
        prim_acc!(graph, r, initialisedvoisins = (k != 1))
        set_enfants!(graph, reset = (k != 1))
        #graph contient arboresence minimale (par les enfants ou les parents) avec un node retiré

        #construire le 1-tree à partir de l'arboresence
        add_node!(graph, removedNode)
        onetree!(graph, removedEdges, removedNode)
        #graph contient un 1-tree minimal par les enfants

        #calculer w, W, d, v
        w = LTπ(graph) - 2*sum(π)
        W = max(W, w)
        degrees!(v, graph, removedNode)
        v .-= 2

        #modification des π dans le sens du gradient
        Δπ = v .* t(k)
        π .+= Δπ
        k += 1
        stopcriterion = k > maxiter
    end 
end


"""
Renvoie la somme des couts d'une tournée par l'ordre des nodes d'un graph.
Fonction très lourde, elle ne sert qu'a tester l'implémentation, elle n'en fait pas partie.
"""
function weighttournee(graph::Graph{T, I}) where {T, I}
    somme = 0.
    #pour chaque sommet et le prochaine dans nodes(graph), trouve l'edge qui les relient
    for i in 1:nb_nodes(graph)-1
        node1 = nodes(graph)[i]
        node2 = nodes(graph)[i+1]
        for edge in edges(graph)
            if (data(edge)[1] == node1 && data(edge)[2] == node2) ||
               (data(edge)[2] == node1 && data(edge)[1] == node2)
               somme += weight(edge)
               break
            end
        end
    end

    #trouve l'edge qui ferme le cycle entre le premier et le dernier sommet
    node1 = nodes(graph)[end]
    node2 = nodes(graph)[1]
    for edge in edges(graph)
        if (data(edge)[1] == node1 && data(edge)[2] == node2) ||
           (data(edge)[2] == node1 && data(edge)[1] == node2)
           somme += weight(edge)
           break
        end
    end
    return somme
end

"""
Teste le cout minimal de la tournée trouvée par rsl!() sur le graphe en exemple du cours.
"""
function test_rsl(graph::Graph{T, I}, s::Node{T}) where{T, I}
    rsl!(graph, s)
    @test weighttournee(graph) == 48
    println("G exemple du cours ✓")
end

"""
Teste la fonction rsl! sur tous les fichiers .tsp.
"""
function test_rsl_all(path, solutions)
    for file_name in readdir(path)
		if file_name[end-3:end] == ".tsp"  && file_name != "pa561.tsp"
            
            println(file_name)
            graph = createGraph(string(file_name), string(path, "/", file_name))
            
            graph1 = deepcopy(graph)
            test_rsl_1racine(graph1, nodes(graph1)[1], "premier sommet", file_name, solutions)

            graph2 = deepcopy(graph)
            test_rsl_1racine(graph2, data(minimum(edges(graph2)))[1], "noeud1 arête cout min", file_name, solutions)

            graph3 = deepcopy(graph)
            test_rsl_1racine(graph3, data(minimum(edges(graph3)))[2], "noeud2 arête cout min", file_name, solutions)
            
            @printf("\t\tcout minimal: %.2e \t solution optimale\n\n", solutions[file_name[1:end-4]])
        end
    end
end

"""
Test la fonction rsl! sur un certaine instance avec une racine donnée.
"""
function test_rsl_1racine(graph::Graph{T, I}, racine::Node{T}, racinetype::String, file_name::String, solutions::Dict) where {T, I}
    rsl!(graph, racine)
    for node in nodes(graph)
        if name(node) == name(racine)
            @test parent(node) === nothing
        else
            @test parent(node) !== nothing
        end
    end
    weightheuristique = weighttournee(graph)

    if file_name != "brg180.tsp"
        @test weightheuristique <= solutions[file_name[1:end-4]]*2
        @printf("\t✓\tcout minimal: %.2e, %.0f",weightheuristique, weightheuristique/solutions[file_name[1:end-4]]*100)
        println("% avec $racinetype")
    else
        @printf("\tX\tcout minimal: %.2e, %.0f",weightheuristique, weightheuristique/solutions[file_name[1:end-4]]*100)
        println("% avec $racinetype")
    end
end

solutiontournee = Dict("bayg29" => 1610,
"bays29" => 2020,
"brazil58" => 25395,
"brg180" => 1950,
"dantzig42" => 699,
"fri26" => 937,
"gr17" => 2085,
"gr21" => 2707,
"gr24" => 1272,
"gr48" => 5046,
"gr120" => 6942,
"hk48" => 11461,
"pa561" => 2763,
"swiss42" => 1273)

#Les lignes qui suivent sont exécutées en démonstration dans le fichier Pluto.

#test_prim(deepcopy(Gexcours), a, prim_acc!)
#test_prim_all("mth6412b-starter-code/instances/stsp", prim_acc!)
#
#test_rsl_all("mth6412b-starter-code/instances/stsp", solutiontournee)

gtest = createGraph("gtest", raw"instances/stsp/gr17.tsp")
hk!(gtest, nodes(gtest)[2])
