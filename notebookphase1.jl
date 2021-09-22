### A Pluto.jl notebook ###
# v0.15.1

using Markdown
using InteractiveUtils

# ╔═╡ fb342ce0-b190-4c11-84ea-29ac39e7ec0d
begin
	import Pkg
	Pkg.add("Plots")
end

# ╔═╡ 7bb02a50-1beb-11ec-0373-55b03b747fe4
begin
	include("projet/phase1/node.jl")
	include("projet/phase1/edge.jl")
	include("projet/phase1/read_stsp.jl")
	include("projet/phase1/graph.jl")
	include("projet/phase1/main.jl")
end

# ╔═╡ 395664c0-0ae8-494c-8307-861d15bc2c93
create_graph("instances/stsp/bayg29.tsp")

# ╔═╡ 9d0629ce-7a04-4615-a334-1893241b86b6


# ╔═╡ 6c2b5c97-20f4-4a25-bade-064c1e278875


# ╔═╡ 57e30d05-1ef2-4dad-9e96-0aafe0f18253


# ╔═╡ Cell order:
# ╠═fb342ce0-b190-4c11-84ea-29ac39e7ec0d
# ╠═7bb02a50-1beb-11ec-0373-55b03b747fe4
# ╠═395664c0-0ae8-494c-8307-861d15bc2c93
# ╠═9d0629ce-7a04-4615-a334-1893241b86b6
# ╠═6c2b5c97-20f4-4a25-bade-064c1e278875
# ╠═57e30d05-1ef2-4dad-9e96-0aafe0f18253
