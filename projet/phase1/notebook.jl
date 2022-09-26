### A Pluto.jl notebook ###
# v0.19.11

using Markdown
using InteractiveUtils

# ╔═╡ 414ab42a-a732-4c8b-a637-b1bb56d25f67
include("node.jl");

# ╔═╡ 82e8d64f-4cb2-485f-ad94-4e0ada319de6
md"""# *Le Rapport est réalisé par* :"""
 

# ╔═╡ 8bba243f-a79f-4668-931e-a8ddba8b3e33
md"""*Flore Caye*"""
 

# ╔═╡ 67b194db-4f68-4644-a2ae-2830ed47eb0d
md""" *Fairouz Mansouri* """

# ╔═╡ e1105d50-3b72-11ed-09ac-2b9dba643c99
md"""# **Rapport sur la phase 1 du projet**"""

# ╔═╡ 6b7c4883-cb13-4e2c-9f23-d368dce888e2
md""" ## 2. Proposer un type Edge pour représenter les arêtes d’un graphe."""

# ╔═╡ a43ca22f-5839-4246-84c2-5db385a63e7b

md"""Type abstrait dont d'autres types d'aretes dériveront, le type abstrait utilise le type node pour pouvoir excuté les instruction de type edge, "une arete est un couple de noeuds"."""



# ╔═╡ ea741c0b-eb05-4f54-b8cb-8a9078c47739
abstract type AbstractEdge{T} end

# ╔═╡ 08094a10-6e07-4163-8ffc-fcfd18e01336
md"""Type représentant les aretes d'un graphe."""

# ╔═╡ 249f5de2-a7ae-4b34-86f3-98021d60661c

mutable struct Edge{T} <: AbstractEdge{T}
  ends::Tuple{Node{T}, Node{T}}
  weight::Int
end


# ╔═╡ f5fe7ce8-938d-4e70-8d2b-f7c6ad33c025
ends(edge::AbstractEdge) = edge.ends

# ╔═╡ ef71b3c3-044b-4505-a5ed-21f4bfea5254
weight(edge::AbstractEdge) = edge.weight

# ╔═╡ f667c88c-2d4b-4531-b450-75f6d6359ebb
md"""Une fonction qui permet d'afficher une arête """


# ╔═╡ 25cf2045-c63a-420a-b733-729ca5dc566f
function show(edge::AbstractEdge)
  println( "Edge  $(start_node(edge)) to $(end_node(edge)) weight: $(weight(edge))" )
end

# ╔═╡ a395a075-8af7-4775-8874-e90de142b9cd
md"""### 3. Étendre le type Graph afin qu’un graphe contien ses arêtes. On se limite ici aux graphes non orientés. L’utilisateur doit pouvoir ajouter une arête à la fois à un graphe."""

# ╔═╡ 84334c9a-4adc-4e01-8eb1-3cee152a56f3
md"""On a rajouter la focntion qui permet d'ajouter une arête au graphe dans le fichier graph.jl, ce qui permet aussi à l'utilisateur de pouvoir ajouter une arête à la fois à un graphe"""

# ╔═╡ c5c86e47-f1d1-4851-8e99-553b9ea9191f
md"""
```julia
function add_edge!(graph::Graph{T}, edge::Edge{T}) where T
  push!(graph.edges, edge)
  graph
end
```
"""

# ╔═╡ 4824161b-826b-4520-9a56-6701e827e7c4
md"""Puis on'ajouté ces deux structeurs, pour le renvoie la liste des edges du graphe et l'autre pour renvoie le nombre des edges du graphe""" 

# ╔═╡ 427b33b8-d721-40b5-8fb6-10f0a5039c0e
md"""
```julia 
	edges(graph::AbstractGraph) = graph.edges
    nb_edges(graph::AbstractGraph) = length(graph.edges)
```
"""

# ╔═╡ 8d10aaf2-6dd4-48dd-a4d8-c3394be0ea8b
md""" #### 4. Étendre la méthode d’affichage show d’un objet de type Graph afin que les arêtes du graphe soient également affichées"""

# ╔═╡ 489ab257-c83e-41df-85aa-d8ba7b4e58aa
md"""Pour Afficher un graphe, on a rajouter cette structeure dans la facontion qui permet d'afficher un graphe avec ces arêtes."""

# ╔═╡ eb88bb06-4a3d-4f99-940c-3c73a6f8e28a
md"""
```julia 
println(".........."$(nb_edges(graph)).")
for edge in edges(graph)
    show(edge)
  end
```
"""

# ╔═╡ 458ba650-4cff-4197-8d3b-311fdb835550
md"""La fonction qui permet d'afficher un graphe avec ces noeuds et ces arêtes est :"""

# ╔═╡ 6a7f4151-8ff1-4309-8285-389461cc49c3
md"""
````julia 
function show(graph::Graph)
  println("Graph ", name(graph), " has ", nb_nodes(graph), " nodes and $(nb_edges(graph)).")
  for node in nodes(graph)
    show(node)
  end
  for edge in edges(graph)
    show(edge)
  end
end
````
"""

# ╔═╡ 3f491c1a-c8f7-4ab3-9291-d97186e1b766
md""" ##### 5. Étendre la fonction read_edges() de read_stsp.jl afin de lire les poids des arêtes (ils sont actuellement ignorés)."""

# ╔═╡ 6015bbfc-29e6-4b01-8757-b65429cf4b11
md"""Dans la function read_edges() de fichier readstsp.jl on a rajouté une instruction  dans la boucle for aprés le choix de type de la martcie il va lire chaque arête du graphe aprés juste cette lecteure on ajoute cette instruction qui permet de lire le poid de cette arête( il met ce poid dans un tableau weights). la fonction parse() permet d'analyser une chaîne comme un nombre. À la fin de la function read_edges() elle va returné edges, weights ."""  

# ╔═╡ e4a2d04c-d481-4112-94fd-9db9ccc206cd
md"""Analyse un fichier .tsp et renvoie l'ensemble des arêtes sous la forme d'un tableau et leurs poids respectifs sous la forme d'un tableau."""

# ╔═╡ 39dc6513-194c-40f5-81c2-aabc2eeced96
md"""
```julia
#Recuperer les poids
              push!(weights, parse(Int, data[j+1]))
           ............
           ............
#returner un tableau des arêtes  et un tableur qui contient les poids de ces arêtes dans le meme ordre  
            return edges, weights
```
"""

# ╔═╡ eb4e0604-31f1-4e52-8622-cc4b76868861
md""" ###### 6. Fournir un programme principal qui lit une instance de TSP symétrique dont les poids sont donnés au format EXPLICIT et construit un objet de type Graph correspondant."""


# ╔═╡ fd55a5e5-c5a6-4900-bb8e-25f100ed7b04
md""" D'abord on fait include("./read_stsp.jl") pour inclure tous les pbjets et les fonctions nécessaires."""
 

# ╔═╡ df0da683-1513-4eee-8ea7-bb7df4ba42df
md""" * apres ecrire un fonction qui permet de :
    * Lis le fichier tsp et en extrait les données
    * Construit l'objet Graph 
    * Construit les objets Nodes (explicites ou implicites)
    * Construit les objets Edges
    
    Retourne le graph associé au fichier donné en argument.
"""

# ╔═╡ 6a983088-c063-42cd-85ab-86e29358ca7f
md""" Dans le type graphe on cré une fonction get_node pour Retourner l'indice dans le vecteur des noeuds du graphe graph du noeud s. NaN si le noeud ne fait pas parti du graphe."""


# ╔═╡ ca22de5a-d4bc-4fc0-a8b9-bb189d9787a6
md"""
```julia 
function get_node(graph::Graph, s::String) 
  i = findfirst(x -> ( name(x) == s), nodes(graph))  
  if i>0 
    return nodes(graph)[i] 
  else
    @warn("Graph $(name(graph)) has no node $s")
    return NaN
  end
end
```
"""

# ╔═╡ c5731c00-0ad5-44a5-af0e-5ef520f8bda4
md"""
```julia


function build_graph(filename::String)
    graph_nodes, graph_edges, edges_brut, weights = read_stsp(filename)
    header = read_header(filename)

    ### Construire les nodes
    if header["DISPLAY_DATA_TYPE"] == "TWOD_DISPLAY" || header["DISPLAY_DATA_TYPE"] == "COORD_DISPLAY"
        g = Graph{Vector{Float64}}("Mon graphe", Vector{Node}(), Vector{Edge}())
        for n in keys(graph_nodes)
            add_node!(g, Node("$(n)", graph_nodes[n]))
        end
    else
        g = Graph{Nothing}("Mon graphe", Vector{Node}(), Vector{Edge}())
        for i in 1:parse(Int, header["DIMENSION"])
            add_node!(g, Node("$(i)", nothing))
        end
    end


    ### Construire les edges 
    g_nodes = nodes(g)
    for i in eachindex(edges_brut)
        #Si le format des donnees est tel que les aretes i-i sont explicitées (edge_weight_format) et le poid d'une telle arete est nul, et c'est bien une arete i-i, alors on ne cré pas l'arete. 
        #Autrement elle est créée et ajoutée au graphe.
        if header["EDGE_WEIGHT_FORMAT"] in ["FULL_MATRIX", "UPPER_DIAG_ROW", "LOWER_DIAG_ROW"] && weights[i]==0 && edges_brut[i][1] == edges_brut[i][2] 
        else
            # Fonction get_node renvoie l'objet Node dans g en fonction de son nom
            u = get_node(g, "$(edges_brut[i][1])")
            v = get_node(g, "$(edges_brut[i][2])")
            edge = Edge{typeof(data(u))}((u,v),weights[i])
            add_edge!(g, edge)
        end
    end
    show(g)
    return g
end


```
"""

# ╔═╡ 3c7b8640-0b2e-475f-9e40-dd982c0f60aa
md""" Pour lancer le programme:
    * Se placer dans le dossier projet/phase1
    * lancer julia main.jl "Nom de l'instance".tsp 
    exemple:
        julia main.jl gr17.tsp
        """

# ╔═╡ ae92573d-bf34-4952-9bd7-5df0ebf6cb36
md"""
```julia
filename = ARGS[1]
build_graph("../../instances/stsp/$(filename)")
```
"""

# ╔═╡ a3900f6e-869a-4064-975c-c6ff60e1d2f7
md""" L'adresse de dépot est : https://github.com/FloreLC/mth6412b-starter-code.git
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.1"
manifest_format = "2.0"
project_hash = "da39a3ee5e6b4b0d3255bfef95601890afd80709"

[deps]
"""

# ╔═╡ Cell order:
# ╟─82e8d64f-4cb2-485f-ad94-4e0ada319de6
# ╟─8bba243f-a79f-4668-931e-a8ddba8b3e33
# ╟─67b194db-4f68-4644-a2ae-2830ed47eb0d
# ╟─e1105d50-3b72-11ed-09ac-2b9dba643c99
# ╟─6b7c4883-cb13-4e2c-9f23-d368dce888e2
# ╟─a43ca22f-5839-4246-84c2-5db385a63e7b
# ╠═414ab42a-a732-4c8b-a637-b1bb56d25f67
# ╠═ea741c0b-eb05-4f54-b8cb-8a9078c47739
# ╟─08094a10-6e07-4163-8ffc-fcfd18e01336
# ╠═249f5de2-a7ae-4b34-86f3-98021d60661c
# ╠═f5fe7ce8-938d-4e70-8d2b-f7c6ad33c025
# ╠═ef71b3c3-044b-4505-a5ed-21f4bfea5254
# ╟─f667c88c-2d4b-4531-b450-75f6d6359ebb
# ╠═25cf2045-c63a-420a-b733-729ca5dc566f
# ╟─a395a075-8af7-4775-8874-e90de142b9cd
# ╟─84334c9a-4adc-4e01-8eb1-3cee152a56f3
# ╟─c5c86e47-f1d1-4851-8e99-553b9ea9191f
# ╟─4824161b-826b-4520-9a56-6701e827e7c4
# ╟─427b33b8-d721-40b5-8fb6-10f0a5039c0e
# ╟─8d10aaf2-6dd4-48dd-a4d8-c3394be0ea8b
# ╟─489ab257-c83e-41df-85aa-d8ba7b4e58aa
# ╟─eb88bb06-4a3d-4f99-940c-3c73a6f8e28a
# ╟─458ba650-4cff-4197-8d3b-311fdb835550
# ╟─6a7f4151-8ff1-4309-8285-389461cc49c3
# ╟─3f491c1a-c8f7-4ab3-9291-d97186e1b766
# ╟─6015bbfc-29e6-4b01-8757-b65429cf4b11
# ╟─e4a2d04c-d481-4112-94fd-9db9ccc206cd
# ╟─39dc6513-194c-40f5-81c2-aabc2eeced96
# ╟─eb4e0604-31f1-4e52-8622-cc4b76868861
# ╟─fd55a5e5-c5a6-4900-bb8e-25f100ed7b04
# ╟─df0da683-1513-4eee-8ea7-bb7df4ba42df
# ╟─6a983088-c063-42cd-85ab-86e29358ca7f
# ╟─ca22de5a-d4bc-4fc0-a8b9-bb189d9787a6
# ╟─c5731c00-0ad5-44a5-af0e-5ef520f8bda4
# ╟─3c7b8640-0b2e-475f-9e40-dd982c0f60aa
# ╟─ae92573d-bf34-4952-9bd7-5df0ebf6cb36
# ╟─a3900f6e-869a-4064-975c-c6ff60e1d2f7
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
