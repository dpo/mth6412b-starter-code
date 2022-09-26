### A Pluto.jl Dnotebook ###
# v0.19.11
"""Rapport phase1 """
using Markdown
using InteractiveUtils

# ╔═╡ 82e8d64f-4cb2-485f-ad94-4e0ada319de6
md"""# *Le Rapport est réalisé par* :"""
 

# ╔═╡ 8bba243f-a79f-4668-931e-a8ddba8b3e33
md"""*Flore Caye*"""
 

# ╔═╡ 67b194db-4f68-4644-a2ae-2830ed47eb0d
md""" *Fairouz Mansouri* """

# ╔═╡ e1105d50-3b72-11ed-09ac-2b9dba643c99
md"""# **Rapport sur la pahse 1 du projet**"""

# ╔═╡ 6b7c4883-cb13-4e2c-9f23-d368dce888e2
md""" ## 2. Proposer un type Edge pour représenter les arêtes d’un graphe."""

# ╔═╡ a43ca22f-5839-4246-84c2-5db385a63e7b

md"""Type abstrait dont d'autres types d'aretes dériveront."""



# ╔═╡ ea741c0b-eb05-4f54-b8cb-8a9078c47739
abstract type AbstractEdge{T} end

# ╔═╡ 08094a10-6e07-4163-8ffc-fcfd18e01336
md"""Type représentant les aretes d'un graphe."""

# ╔═╡ 249f5de2-a7ae-4b34-86f3-98021d60661c
mutable struct Edge{T} <: AbstractEdge{T}
  ends::Tuple{Node{T}, Node{T}}
  weight::Int
end

ends(edge::AbstractEdge) = edge.ends

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
function add_edge!(graph::Graph{T}, edge::Edge{T}) where T
  push!(graph.edges, edge)
  graph
end

# ╔═╡ 4824161b-826b-4520-9a56-6701e827e7c4
md"""Puis on ajouter ces deux structeurs, pour le renvoie la liste des edges du graphe et l'autre pour renvoie le nombre des edges du graphe""" 

# ╔═╡ 2b87bd3d-3c20-48be-8eb3-692303dc4e31
edges(graph::AbstractGraph) = graph.edges
nb_edges(graph::AbstractGraph) = length(graph.edges)

# ╔═╡ 8d10aaf2-6dd4-48dd-a4d8-c3394be0ea8b
md""" #### 4. Étendre la méthode d’affichage show d’un objet de type Graph afin que les arêtes du graphe soient également affichées"""

# ╔═╡ 489ab257-c83e-41df-85aa-d8ba7b4e58aa
md"""Pour Affiche un graphe, on a rajouter cette structeure dans la facontion qui permet d'afficher un graphe avec ces arêtes."""

# ╔═╡ eb88bb06-4a3d-4f99-940c-3c73a6f8e28a
println(".........."$(nb_edges(graph)).")
for edge in edges(graph)
    show(edge)
  end

# ╔═╡ 458ba650-4cff-4197-8d3b-311fdb835550
md"""La fonction qui permet d'afficher un graphe avec c'est noeuds et ces arêtes est :"""

# ╔═╡ 6a7f4151-8ff1-4309-8285-389461cc49c3
function show(graph::Graph)
  println("Graph ", name(graph), " has ", nb_nodes(graph), " nodes and $(nb_edges(graph)).")
  for node in nodes(graph)
    show(node)
  end
  for edge in edges(graph)
    show(edge)
  end
end

# ╔═╡ 3f491c1a-c8f7-4ab3-9291-d97186e1b766
md""" ##### 5. Étendre la fonction read_edges() de read_stsp.jl afin de lire les poids des arêtes (ils sont actuellement ignorés)."""

# ╔═╡ 6015bbfc-29e6-4b01-8757-b65429cf4b11
md"""Dans la function read_edges() de fichier readstsp.jl on a rajouté un une instruction  dans la boucle for aprés le choix de type de la martcie il va lire chaque arête du graphe aprés juste cette lecteure on ajoute cette instruction qui permet de lire le poid de cette arête( il met ce poid dans un tableau weights). la fonction parse() permet d'analyser une chaîne comme un nombre. À la fin de la function read_edges() elle va returné edges, weights ."""  

# ╔═╡ 39dc6513-194c-40f5-81c2-aabc2eeced96
#Recuperer les poids
            push!(weights, parse(Int, j))
           ............
           ............
#returner un tableau des arêtes  et un tableur qui contient les poids de ces arêtes  
            return edges, weights

# ╔═╡ eb4e0604-31f1-4e52-8622-cc4b76868861
md""" ###### 6. Fournir un programme principal qui lit une instance de TSP symétrique dont les poids sont donnés au format EXPLICIT et construit un objet de type Graph correspondant."""


# ╔═╡ 83b3cbbf-1f42-41b9-8256-76b16a495454


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
# ╠═ea741c0b-eb05-4f54-b8cb-8a9078c47739
# ╟─08094a10-6e07-4163-8ffc-fcfd18e01336
# ╠═249f5de2-a7ae-4b34-86f3-98021d60661c
# ╟─f667c88c-2d4b-4531-b450-75f6d6359ebb
# ╠═25cf2045-c63a-420a-b733-729ca5dc566f
# ╟─a395a075-8af7-4775-8874-e90de142b9cd
# ╟─84334c9a-4adc-4e01-8eb1-3cee152a56f3
# ╠═c5c86e47-f1d1-4851-8e99-553b9ea9191f
# ╟─4824161b-826b-4520-9a56-6701e827e7c4
# ╠═2b87bd3d-3c20-48be-8eb3-692303dc4e31
# ╟─8d10aaf2-6dd4-48dd-a4d8-c3394be0ea8b
# ╟─489ab257-c83e-41df-85aa-d8ba7b4e58aa
# ╠═eb88bb06-4a3d-4f99-940c-3c73a6f8e28a
# ╟─458ba650-4cff-4197-8d3b-311fdb835550
# ╠═6a7f4151-8ff1-4309-8285-389461cc49c3
# ╟─3f491c1a-c8f7-4ab3-9291-d97186e1b766
# ╟─6015bbfc-29e6-4b01-8757-b65429cf4b11
# ╠═39dc6513-194c-40f5-81c2-aabc2eeced96
# ╟─eb4e0604-31f1-4e52-8622-cc4b76868861
# ╠═83b3cbbf-1f42-41b9-8256-76b16a495454
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002