### A Pluto.jl notebook ###
# v0.16.1

using Markdown
using InteractiveUtils

# ╔═╡ 5a00dbe0-3dd4-4f24-aebe-174de68724ce
begin
    import Pkg
	Pkg.add("Plots")
	
end

# ╔═╡ 5e196205-7c7b-4abb-9294-8d1cde587df9
begin
using Markdown
using InteractiveUtils
end

# ╔═╡ f412df0e-910c-43af-8ee3-37b4c124b1db
begin
using Images
exemple = load("/Users/admin/Documents/PhD Courses/MT6412B/Projet/mth6412b-starter-code/projet/phase1/exemple.png")
end

# ╔═╡ aafbc9da-a403-49e4-b4f4-e9c17b9008c6
begin
	include("/Users/admin/Documents/PhD Courses/MT6412B/Projet/mth6412b-starter-code/projet/phase1/node.jl")
	include("/Users/admin/Documents/PhD Courses/MT6412B/Projet/mth6412b-starter-code/projet/phase1/edge.jl")
	include("/Users/admin/Documents/PhD Courses/MT6412B/Projet/mth6412b-starter-code/projet/phase1/read_stsp.jl")
	include("/Users/admin/Documents/PhD Courses/MT6412B/Projet/mth6412b-starter-code/projet/phase1/graph.jl")
	include("/Users/admin/Documents/PhD Courses/MT6412B/Projet/mth6412b-starter-code/projet/phase1/main.jl")
end

# ╔═╡ a40d8394-4283-49c4-8dae-a220e0612ee3
md"# Ecole polytechnique de Montréal"

# ╔═╡ 325540e9-bdd8-498b-a003-05de98f8b4de
		md"### MTH6412B		Session Automne  2021 "

# ╔═╡ fc911268-1ca1-11ec-3cea-316e634ec1f1
md"## Rapport de projet"

# ╔═╡ aae45e52-3b2c-4dbf-b800-5ad74e32e107
md" ### Pierre Mordant & Mahamadou Sarité"

# ╔═╡ f111cda5-de3d-4616-9a8a-cb4e4169ae89
md"### Phase 1"

# ╔═╡ 92c9398d-4310-4aa6-8236-adb8e005b3da
begin
md" Dans cette première phse du projet sur le problème du voyageur de commerce symétrique, nous définissons des structures de données de base adéquates.
Nous procédons à des modifications des codes de démarrages et à proposer:
  1. Un type Edge pour présenter les arêtes d'un graphe.
  2. Etendre le type Graph afin qu'un graphe contienne ses arêtes.
  3. Etendre la méthode d'affichage show d'un objet de type Graph afin que les arêtes du graphe soient également affichées
  4. Etendre la fonction read _ edges() de read _ stsp.jl afin de lire les poids des arêtes.
  5. Fournir un programme principal main() qui lit une instance de TSP symétrique dont les poids sont donnés au format EXPLICIT et construit un objet de type Graph correspondant."
end

# ╔═╡ 42cce623-9fe6-4988-b92a-0f7c993eb2b0
begin 
md" Le type Edge est défini avec 3 attributs comme suit: les deux sommets (string, string) reliés par l'arête et le poids de cette arête (Int). Par exemple, l'arête Edge(\"1\" , \"5\" , 86) reliant le noeud 1 au noeud 5 ayant pour poids 86 dans le fichier EXPLICIT bayg29.tsp.  voir la capture ci-dessous pour lus de visualisation.  \
	Le type Graph renvoie un vecteur des données à format flottant (Float64). Ces données sont composées d'un nom Graph, d'une liste de noeuds (Node) et d'une liste d'arêtes (Edge). Le type Graph a été modifié pour permettre l'inclusion des arêtes.\
	Le programme principal main.jl a été élaboré pour lire une instance TSP symétrique dont les poids sont au format EXPLICIT.\
	
L'utilisateur fait appel à la fonction create_graph(\"chemin du fichier EXPLICIT\") dans Julia pour générer le graphe correspondant dans le Terminal. Comme indiqué dans la capture ci-dessous. "
end

# ╔═╡ d42ef91f-2379-44f4-906a-2ea2d9a744e6
md" ## Afficahge de graphes "

# ╔═╡ 26d4f974-251c-4820-b074-bb70277aaf7e
md" On fait appel à nos codes sources node.jl, edege.jl, graph.jl, read_stsp.jl et main.jl ."

# ╔═╡ 9e221536-fa6a-4f83-9f4c-313b6d698dd2
md" Quelques exemples de graphes :"

# ╔═╡ e9a1dad6-e79e-4a21-bf40-f48c11119cdf
create_graph("/Users/admin/Documents/PhD Courses/MT6412B/Projet/mth6412b-starter-code/projet/instances/stsp/fri26.tsp")

# ╔═╡ bd8cc6a7-9bc2-4f1f-bf02-20c052630563
create_graph("/Users/admin/Documents/PhD Courses/MT6412B/Projet/mth6412b-starter-code/projet/instances/stsp/bays29.tsp")

# ╔═╡ 076248f9-5916-4e34-b8fc-fd8f786db778
display(plot_graph("/Users/admin/Documents/PhD Courses/MT6412B/Projet/mth6412b-starter-code/projet/instances/stsp/bays29.tsp"))

# ╔═╡ 9645dcb3-c614-414f-b927-4e1ae089819f
begin
	md"## Références: 
	1. Notes de cours
	2. "
end

# ╔═╡ Cell order:
# ╟─5a00dbe0-3dd4-4f24-aebe-174de68724ce
# ╟─5e196205-7c7b-4abb-9294-8d1cde587df9
# ╠═a40d8394-4283-49c4-8dae-a220e0612ee3
# ╠═325540e9-bdd8-498b-a003-05de98f8b4de
# ╠═fc911268-1ca1-11ec-3cea-316e634ec1f1
# ╠═aae45e52-3b2c-4dbf-b800-5ad74e32e107
# ╠═f111cda5-de3d-4616-9a8a-cb4e4169ae89
# ╟─92c9398d-4310-4aa6-8236-adb8e005b3da
# ╠═42cce623-9fe6-4988-b92a-0f7c993eb2b0
# ╟─f412df0e-910c-43af-8ee3-37b4c124b1db
# ╟─d42ef91f-2379-44f4-906a-2ea2d9a744e6
# ╟─26d4f974-251c-4820-b074-bb70277aaf7e
# ╠═aafbc9da-a403-49e4-b4f4-e9c17b9008c6
# ╟─9e221536-fa6a-4f83-9f4c-313b6d698dd2
# ╟─e9a1dad6-e79e-4a21-bf40-f48c11119cdf
# ╟─bd8cc6a7-9bc2-4f1f-bf02-20c052630563
# ╠═076248f9-5916-4e34-b8fc-fd8f786db778
# ╠═9645dcb3-c614-414f-b927-4e1ae089819f
