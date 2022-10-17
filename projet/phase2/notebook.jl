### A Pluto.jl notebook ###
# v0.19.11

using Markdown
using InteractiveUtils

# ╔═╡ 0adf514a-4e1a-11ed-3a00-856fd5050585
md"""## Projet du voyageur de commerce : Phase 1"""

# ╔═╡ 99956331-b417-48ae-833b-cb98784b4f27
md"""Abdou Samad Dicko(2037205), Clélia Merel(2163025), Myriam Lévy(2225114)"""

# ╔═╡ 96a61622-9d2e-4065-964a-251e342ce7ec
md"""### Création de la strcture *Comp*
Cette structure permet de représenter les composantes connexes d'un graphe. Comme suggéré en lab, elle contient deux attributs : une racine de typer *Node* et une liste d'enfants sous forme de tuples de type (*Node*, *Node*) où le premier élément est un nœud de la composante connexe et le deuxième est son parent. La racine est dans cette liste et elle est son propre parent. Pour l'instant, on ne se sert pas de cette association parent-enfant dans nos fonctions mais elle permet par exemple de remonter jusqu'à la racine à partir de n'importe quel nœud enfant. 

```julia
abstract type AbstractComp{T} end

mutable struct Comp{T} <: AbstractComp{T}
    root::Node{T}
    children::Vector{Tuple{Node{T}, Node{T}}} #chaque enfant est un tuple de la forme (enfant, parent)
end
```
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.0"
manifest_format = "2.0"
project_hash = "da39a3ee5e6b4b0d3255bfef95601890afd80709"

[deps]
"""

# ╔═╡ Cell order:
# ╟─0adf514a-4e1a-11ed-3a00-856fd5050585
# ╟─99956331-b417-48ae-833b-cb98784b4f27
# ╠═96a61622-9d2e-4065-964a-251e342ce7ec
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
