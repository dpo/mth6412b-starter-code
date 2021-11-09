include("mainphase3.jl")
include("projet/phase4/solutionstats.jl")
using Printf
using Base.Sort
using Statistics

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
Vide les listes d'enfants.
"""
function reset_family!(graph::Graph{T, I}) where{T, I}
    for node in nodes(graph)
        node.parent = nothing
        node.min_weight = Inf
        node.rank = 0
        resize!(node.enfants, 0)
        resize!(node.voisins, 0)
        resize!(node.voisinweights, 0)
    end
end

"""
Remplit les listes d'enfants à partir des attributs parent.
"""
function set_enfants!(graph::Graph{T, I}) where{T, I}
    for node in nodes(graph)
        (parent(node) !== nothing) && (add_enfant!(node.parent, node))
    end
end

"""
Applique l'algorithme de Prim accéléré sur un graphe. Ne renvoie rien.
"""
function prim_acc!(graph::Graph{T, I}, s::Node{T}) where{T, I}
    s.min_weight = 0
    initvoisins!(graph)

    #Initialisation d'une file de sommets de priorité
    file = NodeQueue([node for node in nodes(graph)])
    while !(is_empty(file))

        #t est le sommet de plus haute priorité, i.e. dont le champ min_weight est le plus bas
        t = popfirst!(file)
        for i in 1:nb_voisins(t)
            u = voisins(t)[i]
            weightu = voisinweights(t)[i]

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
    starttime = time()
    prim_acc!(graph, r)
    set_enfants!(graph)

    orderednodes = Node{T}[]
    parcours_preordre!(r, orderednodes)
    graph.nodes = orderednodes

    endtime = time()
    cout = weighttournee(graph)
    endtime_cout = time()

    return RSLsolution(cout, endtime - starttime , endtime_cout - starttime, graph)
end

"""
Renvoie la somme des couts d'une tournée par l'ordre des nodes d'un graph.
Fonction très lourde, elle ne sert qu'à tester l'implémentation, elle n'en fait pas partie.
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
    removedEdges = edges(graph)[edgesToDel]
    deleteat!(edges(graph), edgesToDel)
    return removedEdges
end

"""
Effectue une transformation π sur un les poids des arêtes d'un graphe.
"""
function πtransfo!(graph::Graph{T, I}, vecteurπ::Vector{Float64}) where {T, I}
    for i in 1:nb_nodes(graph)
        nodes(graph)[i].πcost = vecteurπ[i]
    end
    for edge in edges(graph)
        edge.weight += (data(edge)[1].πcost + data(edge)[2].πcost)
    end
end

"""
Construit un one-tree par les attributs enfants des sommets du graphe.
"""
function onetree_prim!(graph::Graph{T, I}, removedEdges::Vector{Edge{T, I}}, oneNode::Node{T}) where {T, I}
    for edge in removedEdges
        add_edge!(graph, edge)
    end
    #ajouter le sommet 1 du 1-tree dans les enfants des deux arêtes de plus petit cout
    minEdge = smallestn!(removedEdges, 2)
    if data(minEdge[1])[1] == oneNode
        push!(enfants(data(minEdge[1])[2]), oneNode)
    elseif data(minEdge[1])[2] == oneNode
        push!(enfants(data(minEdge[1])[1]), oneNode) 
    end
    if data(minEdge[2])[1] == oneNode
        push!(enfants(data(minEdge[2])[2]), oneNode)
    elseif data(minEdge[2])[2] == oneNode
        push!(enfants(data(minEdge[2])[1]), oneNode) 
    end
end

"""
Construit un one-tree par la liste de edges "arbremin".
"""
function onetree_kruskal!(arbremin::Vector{Union{Nothing, Edge{T, I}}}, graph::Graph{T, I}, removedEdges::Vector{Edge{T, I}}, oneNode::Node{T}) where {T, I}
    for edge in removedEdges
        add_edge!(graph, edge)
    end
    #ajouter les deux arêtes de plus petit cout dont une extrémité est le sommet 1 à l'arbre
    minEdge = smallestn!(removedEdges, 2)
    (data(minEdge[1])[1] == oneNode || data(minEdge[1])[2] == oneNode) && (push!(arbremin, minEdge[1]))
    (data(minEdge[2])[1] == oneNode || data(minEdge[2])[2] == oneNode) && (push!(arbremin, minEdge[2]))
end

"""
Calcule la somme des poids sur les arêtes d'un onetree.
"""
function LTπ_prim(graph::Graph{T, I}) where {T, I}
    LT = zero(I)
    for edge in edges(graph)
        if data(edge)[1] ∈ enfants(data(edge)[2]) || data(edge)[2] ∈ enfants(data(edge)[1])
            LT += weight(edge)
        end
    end
    return LT
end

"""
Calcule la somme des poids sur les arêtes d'un onetree.
"""
function LTπ_kruskal(arbremin::Vector{Union{Nothing, Edge{T, I}}}) where {T, I}
    LT = zero(I)
    for edge in arbremin
        LT += weight(edge)
    end
    return LT
end

"""
Écrit dans le vecteur d les degrés des sommets d'un 1-tree.
"""
function degrees_prim!(d::Vector{Int}, graph::Graph{T, I}, oneNode::Node{T}) where {T, I}
    for i in 1:nb_nodes(graph)
        node = nodes(graph)[i]
        if node == oneNode
            d[i] = 2
        else
            d[i] = length(enfants(node))
            if parent(node) !== nothing
                d[i] += 1
            end
        end
    end
end

"""
Écrit dans le vecteur d les degrés des sommets d'un 1-tree.
"""
function degrees_kruskal!(d::Vector{Int}, graph::Graph{T, I}, arbremin::Vector{Union{Nothing, Edge{T, I}}}) where {T, I}
    for edge in arbremin
        push!(voisins(data(edge)[1]), data(edge)[2])
        push!(voisins(data(edge)[2]), data(edge)[1])
    end
    for i in 1:nb_nodes(graph)
        node = nodes(graph)[i]
        d[i] = nb_voisins(node)
    end
end

"""
Fonction décroissante de t par périodes.
"""
function t1(k, n, t0)
    periode = Int(ceil(n/2))
    return t0/2^(Int(ceil(k/periode))-1)
end

"""
Renvoie la liste de edges de la tournée trouvée par held et karp avec l'algorithme de prim.
"""
function prim_to_tree(graph::Graph{T, I}) where {T, I}
    arbre = Vector{Union{Nothing, Edge{T, I}}}(nothing, nb_nodes(graph))
    i = 0
    for edge in edges(graph)
        if data(edge)[1] ∈ enfants(data(edge)[2]) || data(edge)[2] ∈ enfants(data(edge)[1])
            i += 1
            arbre[i] = edge
        end
    end
    arbre
end

"""
Trouve une tournée de cout minimale par l'heuristique de Held et Karp.
"""
function hk!(graph::Graph{T, I},
             r::Node{T};
             algorithm::Symbol=:prim,
             display::Bool=true,
             t0::Float64=50.0,
             maxiter::Int=nb_nodes(graph),
             wmemorysize::Int=5,
             σw::Float64=1.0e-2) where {T, I}
    starttime = time()

    if nb_nodes(graph) <= 1
        endtime = time()
        return  Hksolution(0, "optimal", Edges{T, I}[], 0, 0, endtime - starttime, wmemorysize, graph)
    elseif nb_nodes == 2
        nodes(graph)[1].parent = nodes(graph)[2]
        nodes(graph)[2].parent = nodes(graph)[1]
        endtime = time()
        return Hksolution(0, "optimal", edges(graph), 0, 0, endtime - starttime, wmemorysize, graph)
    end

    k = 1
    W = -Inf
    vecteurπ = zeros(Float64, nb_nodes(graph))
    Δπ = zeros(Float64, nb_nodes(graph))
    v = ones(Int, nb_nodes(graph))
    wmemory = zeros(wmemorysize)
    σmemory = 0.0

    stopcriterion = (all(v .== 0))

    display && @printf("%6s      %5s          %4s         %4s\n    ----------------------------------------------\n", "k", "W", "w", "σ")
    while !(stopcriterion)
        #reset de tous les attributs des sommets pour la prochaine itération
        k == 0 || (reset_family!(graph))

        #trouver arboresence minimale avec un node retiré
        πtransfo!(graph, Δπ)
        removedNode = nodes(graph)[end]
        removedNode.parent = nothing
        removedEdges = removeNodeGraph!(graph, removedNode)

        if algorithm == :prim
            prim_acc!(graph, r)
            set_enfants!(graph)
            #graph contient arboresence minimale (par les enfants ou les parents) avec un node retiré

            #construire le 1-tree à partir de l'arboresence
            add_node!(graph, removedNode)
            onetree_prim!(graph, removedEdges, removedNode)
            #graph contient un 1-tree minimal par les enfants

            #calculer w, W, d, v
            w = LTπ_prim(graph) - 2*sum(vecteurπ)
            W = max(W, w)
            degrees_prim!(v, graph, removedNode)
        elseif algorithm == :kruskal
            arbremin = kruskal(graph)

            #construire le 1-tree à partir du vecteur arbremin
            add_node!(graph, removedNode)
            onetree_kruskal!(arbremin, graph, removedEdges, removedNode)

            #calculer w, W, d, v
            w = LTπ_kruskal(arbremin) - 2*sum(vecteurπ)
            W = max(W, w)
            degrees_kruskal!(v, graph, arbremin)
        else
            error("algorithme inconnu")
        end

        #modification des π dans le sens du gradient
        v .-= 2
        Δπ .= v .* t1(k, nb_nodes(graph), t0)
        vecteurπ .+= Δπ

        #mise à jour des critères d'arrêt
        wmemory[(k % wmemorysize)+1] = w
        k += 1
        σmemory = std(wmemory)
        stopcriterion = (k > maxiter || all(v .== 0) || (σmemory < σw) && k > wmemorysize)

        #affichage
        display && @printf("%8.1i    %8.4e    %8.4e    %8.2e\n", k-1, W, w, σmemory)
        #stopcriterion && @printf("%8.1i    %8.4e    %8.4e    %8.2e\n", k-1, W, w, σmemory)
    end

    algorithm == :prim && (arbremin = prim_to_tree(graph))
    if all(v .== 0)
        status = "optimal"
    elseif k > maxiter
        status = "max iteration"
    else
        status = "non increasing values in last iterations"
    end
    endtime = time()
    return Hksolution(W, status, arbremin, σmemory, k-1, endtime - starttime, wmemorysize, graph)
end

"""
Teste le cout minimal de la tournée trouvée par rsl!() sur le graphe en exemple du cours.
"""
function test_rsl(graph::Graph{T, I}, s::Node{T}) where{T, I}
    solution = rsl!(graph, s)
    @test cout(solution) == 48
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
    solution = rsl!(graph, racine)
    for node in nodes(graph)
        if name(node) == name(racine)
            @test parent(node) === nothing
        else
            @test parent(node) !== nothing
        end
    end
    weightheuristique = cout(solution)

    if file_name != "brg180.tsp"
        @test weightheuristique <= solutions[file_name[1:end-4]]*2
        @printf("\t✓\tcout minimal: %.2e, %.0f",weightheuristique, weightheuristique/solutions[file_name[1:end-4]]*100)
        println("% avec $racinetype")
    else
        @printf("\tX\tcout minimal: %.2e, %.0f",weightheuristique, weightheuristique/solutions[file_name[1:end-4]]*100)
        println("% avec $racinetype")
    end
end

"""
Teste la fonction hk! sur tous les fichiers .tsp. avec les même paramètres pas nécéssairement optimaux
"""
function test_hk_all(path, solutions)
    for file_name in readdir(path)
		if file_name[end-3:end] == ".tsp" && file_name != "pa561.tsp"
            
            println(file_name)
            graph = createGraph(string(file_name), string(path, "/", file_name))
            sol_kruskal = hk!(graph,
                       nodes(graph)[1],
                       algorithm=:kruskal,
                       display=false,
                       t0=30.0,
                       maxiter=300,
                       wmemorysize=5,
                       σw=1.0e-3)
            @test W(sol_kruskal) <= solutions[file_name[1:end-4]]
            @test nothing ∉ arbre(sol_kruskal)
            println("\t✓ avec Kruskal")

            graph = createGraph(string(file_name), string(path, "/", file_name))
            sol_prim = hk!(graph,
                       nodes(graph)[1],
                       algorithm=:prim,
                       display=false,
                       t0=30.0,
                       maxiter=300,
                       wmemorysize=5,
                       σw=1.0e-3)
            @test W(sol_prim) <= solutions[file_name[1:end-4]]
            @test nothing ∉ arbre(sol_prim)
            println("\t✓ avec Prim")
        end
    end
end

"""
Nouvelle méthode de hk!() prenant en argument un chemin.
"""
function hk(graphname::String, path::String; racine::Symbol=:premier, kwargs...)
    graph = createGraph(graphname, path)
    return hk!(graph,  root(racine, graph); kwargs...)
end

"""
Nouvelle méthode de rsl!() prenant en argument un chemin.
"""
function rsl(graphname::String, path::String; racine::Symbol=:premier)
    graph = createGraph(graphname, path)
    return rsl!(graph, root(racine, graph))
end

"""
Renvoie une racine parmis trois options de type `Symbol`: `:premier`, `:dernier` et `:poidsmin`.
"""
function root(racine::Symbol, graph::Graph{T, I}) where{T, I}
    if racine == :premier
        return nodes(graph)[1]
    elseif racine == :dernier
        return nodes(graph)[end]
    elseif racine == :poidsmin
        return data(minimum(edges(graph)))[1]
    else
        error("unknown keyword")
    end
end

"""
Plot une solution par hk ou rsl avec l'erreur relative entre le cout de la solution et le cout optimal.
"""
function plot_tour_gap(solution::AbstractSolution, valeurs_optimales)
    fig = plot_tour(solution)
    valeur_optimale = valeurs_optimales[name(graph(solution))]
    gap = abs(valeur_optimale - cout(solution))/valeur_optimale*100
    annotate!(1700, 2200, text(string("Δ relatif = ", round(gap, digits=2), "%"), :black, :right, 10))
    fig
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

#test_prim(Gexcours, a, prim_acc!)
#test_prim_all("mth6412b-starter-code/instances/stsp", prim_acc!)

#test_rsl_all("mth6412b-starter-code/instances/stsp", solutiontournee)

#test_hk_all("mth6412b-starter-code/instances/stsp", solutiontournee)

#hk("graph", raw"mth6412b-starter-code/instances/stsp/dantzig42.tsp", racine=:premier, algorithm=:prim, display=false, t0=30.0, maxiter=300, wmemorysize=5, σw=1.0e-3)
solution = hk("bays29", raw"mth6412b-starter-code/instances/stsp/bays29.tsp")
plot_tour_gap(solution, solutiontournee)

#solution = rsl("bayg29", raw"mth6412b-starter-code/instances/stsp/bayg29.tsp")
#plot_tour(solution)