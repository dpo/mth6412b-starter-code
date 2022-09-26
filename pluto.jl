### A Pluto.jl notebook ###
# v0.19.11

using Markdown
using InteractiveUtils

# ╔═╡ 775f23b8-3da3-11ed-1dab-2b8e6238fd87
md"""## Projet du voyageur de commerce : Phase 1"""

# ╔═╡ 042d77b3-a2cd-4c34-9386-c3bf50c01314
md"""Abdou Samad Dicko(2037205), Clélia Merel(2163025), Myriam Lévy(2225114)"""

# ╔═╡ 5cb5ba5e-c685-43f6-9cf5-fafcbaa501c2
md"""### Création du type *Edge*"""

# ╔═╡ 48187bd9-94bf-4e9a-b106-9589a2888290
md""" 

# ╔═╡ 599b356c-bbf6-429e-ac27-0518a86c36a9
md"""
```julia
abstract type AbstractEdge{T} end

mutable struct Edge{T} <: AbstractEdge{T}
  nodes::Tuple{Node{T}, Node{T}}
  weight::Number
end

nodes(edge::AbstractEdge) = edge.nodes

weight(edge::AbstractEdge) = edge.weight

function show(edge::AbstractEdge)
  println("Edge ", nodes(edge), ", weight: ", weight(edge))
end
``` """

# ╔═╡ 23ea2ccb-059b-4d33-b2bc-cc25827a5141
md"""### Extension du type *Graph*"""

# ╔═╡ de1a416c-38dd-4008-abb6-5fcc2318a703
md"""### Extension de la méthode *show*"""

# ╔═╡ 053ff6bd-47ce-42d3-86df-ba6822a33aaa


# ╔═╡ 690bc9ef-640c-4f96-944f-7684b8311c6f
md"""### Extension de la fonction *read_edges()*"""

# ╔═╡ 6229c1f9-99bd-4723-a338-8b6e46eb2ef8
md"""### Création de la fonction *make_graph()*"""

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
# ╟─775f23b8-3da3-11ed-1dab-2b8e6238fd87
# ╟─042d77b3-a2cd-4c34-9386-c3bf50c01314
# ╟─5cb5ba5e-c685-43f6-9cf5-fafcbaa501c2
# ╠═48187bd9-94bf-4e9a-b106-9589a2888290
# ╟─599b356c-bbf6-429e-ac27-0518a86c36a9
# ╟─23ea2ccb-059b-4d33-b2bc-cc25827a5141
# ╟─de1a416c-38dd-4008-abb6-5fcc2318a703
# ╠═053ff6bd-47ce-42d3-86df-ba6822a33aaa
# ╟─690bc9ef-640c-4f96-944f-7684b8311c6f
# ╟─6229c1f9-99bd-4723-a338-8b6e46eb2ef8
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
