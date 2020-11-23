### A Pluto.jl notebook ###
# v0.11.14

using Markdown
using InteractiveUtils

# ╔═╡ e222eeae-fdcb-11ea-18d4-85725dcdfef7
using Pkg

# ╔═╡ a43c3ca0-0591-11eb-0877-e90edd32d010
using PlutoUI

# ╔═╡ e06be140-2d1d-11eb-19eb-39c368aa1849
using LinearAlgebra

# ╔═╡ 68718350-ff8e-11ea-3da4-57a5b1b41c72
include("exceptions.jl")

# ╔═╡ 472da810-fdd4-11ea-2627-af24b931e523
begin
	include("node.jl")
end

# ╔═╡ 5314a490-fdd3-11ea-25ef-2d1f7fc1e992
begin
	include("edge.jl")
end

# ╔═╡ db19e470-fdd5-11ea-2975-41ca92f2cb6d
include("graph.jl")

# ╔═╡ 64c277b0-04b5-11eb-0750-b320f1b4196e
begin 
	include("connected_component.jl")
end

# ╔═╡ 346e3af2-1d5f-11eb-1ec8-671bdd1ab73d
include( "heuristics.jl")

# ╔═╡ 58045670-1d5f-11eb-3f41-956faefc6410
include( "kruskal.jl")

# ╔═╡ 5db82560-1d5f-11eb-3cc8-3f0f181a3748
include("prim.jl")

# ╔═╡ fc270a0e-2d07-11eb-2f97-b3232a53acab
include("tree.jl")

# ╔═╡ 2e7e75c0-2d08-11eb-0b05-8f321fe2e270
include("RSL.jl")

# ╔═╡ 2e4eda40-2d08-11eb-14b7-8f93dbb6f196
include("HK.jl")

# ╔═╡ 0be9edd0-fdcb-11ea-2e0b-99438dea97c4
md"""
# MTH6412B Project: Phase 4
"""

# ╔═╡ f37e7e90-ff88-11ea-1f2c-0ff0dac33bd4
md"""
## Authors: Monssaf Toukal (1850319) and Matteo Cacciola (2044855)
"""

# ╔═╡ 8ad5b910-ff8f-11ea-3835-734df59563c6
md"""
- The code is available by clicking [here](https://github.com/MonssafToukal/mth6412b-starter-code)
"""

# ╔═╡ 6af932d0-fdd1-11ea-2222-4bbb807b0db4
cd(joinpath(@__DIR__, "projet", "phase4"))

# ╔═╡ 11961ed0-fdcf-11ea-2e24-6fe10bafe291
pwd()

# ╔═╡ 5b511e60-fdcc-11ea-2574-fd7e50a08873
Pkg.activate("mth6412b")

# ╔═╡ d1eaae90-fdce-11ea-38ab-070f79ea4f78
md"""
### Here are some functions to display results in the notebook
* `display(filename)` displays the whole file in the notebook
* `display(filename, line1, line2)` displays thelines between the two given lines of the file

"""

# ╔═╡ ceccea60-2d0e-11eb-28ff-3125e7ec774c
md"""
To run the main program, one must:
1. go to the mth-starter-code/projet/phase4 folder
2. run `julia main.jl`

**If one is using VS Code, make sure that you are not running the `main.jl` file with the Julia extension. We encountered problems doing so.**
"""

# ╔═╡ a132cd30-0591-11eb-2517-b15c37fb4fdd
begin	
	function display(filename)
		with_terminal() do
			open(filename, "r") do file
				for line in readlines(file)
					println(stdout, line)
				end
			end
		end
	end

	function display(filename, line1, line2)
		with_terminal() do
			open(filename, "r") do file
				lines = readlines(file)
				for i in line1:line2
					println(stdout, lines[i])
				end
			end
		end
	end
end

# ╔═╡ 7a83ac0e-2d08-11eb-02f4-034f05af6062
md"""
- First we include all the old files we wrote in the previous phases that we will need
"""

# ╔═╡ 42dd0570-0591-11eb-02d8-238f137cf89c
display("exceptions.jl")

# ╔═╡ 145b79d0-1d5f-11eb-07cf-b55cdb5a5fc7
display("Node.jl")

# ╔═╡ 955e1c00-0599-11eb-21fe-0db2e4a54261
display("Edge.jl")

# ╔═╡ c5acbf60-0599-11eb-2883-2d28ad492ab2
display("graph.jl",1,34)

# ╔═╡ facebcc0-0599-11eb-2f85-ffa3dee4d629
display("Connected_component.jl", 1, 18)

# ╔═╡ 6be4617e-1d5f-11eb-2d65-f5bb4f7de7f5
display("kruskal.jl", 1, 29)

# ╔═╡ 6cca2da0-1d5f-11eb-00d3-69943a0ca28b
display("prim.jl")

# ╔═╡ b2fc2770-2d08-11eb-2fd3-5d8c609ec7ac
md"""
We needed to convert our connected component structure to make it possible to do a depth first search, so we created a function that convert a connected component into a tree structure.

Also we implemented the depth first search
"""

# ╔═╡ 2e9495d0-2d08-11eb-3dd4-87515bd8cdec
display("tree.jl")

# ╔═╡ 006a3c8e-2d09-11eb-376f-abe4d1c5d527
md""" Here we have the RSL algorithm implementation

We can choose the root vertex among the nodes of the graph and we can choose the algorithm to use to compute the minimal spanning tree among Kruscal and Prim
"""

# ╔═╡ 2e66f620-2d08-11eb-2e71-83633829c857
display("RSL.jl")

# ╔═╡ 1a185550-2d09-11eb-2a63-9701d8e89f6d
md""" Here we have the HK algorithm implementation


We implemented two version of the algorithm:
- The first one has been proved to achieve convergence for any instance and any intial positive step size (since it is usually slow we will refear to it as slow convergence version). Called step\_size\_0 the initial step size, the step size at iteration k is step\_size\_0/k. As stopping criteria we check if the norm of the gradient, the step_size or the variantion in the weight in the lasti iteration are smoller than our precision. Also a time limit is set.

- The second version has no guarantee of convergence but empirically has shown to converge very quickly, it is known in the litterature as the Lin Kernighan. To have more detail the reader can refer to An "Effective Implementation of the Lin-Kernighan Traveling Salesman Heuristic (Helsgaun) : section 4:1 (page 26).

It is possible to choose:

- the algorithm to use for the minimal spanning tree implementation among Kruskal and Prim;

- The length of the first stepsize

- The precision for stopping crteria

- the version fo the algorithm among slow-convergence and Lin Kernighan

- The maximum time before stopping the algorithm if no other stopping criteria has been triggered
"""

# ╔═╡ 2e35fb10-2d08-11eb-142d-4bde698eb6ba
display("HK.jl")

# ╔═╡ 35926230-2d0e-11eb-31f0-2fb36070bd93
md"""
This is the main body of our principal program
"""

# ╔═╡ 2e1ca6b0-2d08-11eb-1ccc-ab1945757ee8
display("main.jl")

# ╔═╡ 2e0219d0-2d08-11eb-1c48-751a5549c05e
md"""
### Showing hamiltonian cycle returned by the rsl algorithm with bays29.tsp instance
"""

# ╔═╡ b89beda2-2d12-11eb-253f-4b763a273ca6
	filepath = joinpath("..","..","instances", "stsp", "bays29.tsp")

# ╔═╡ 1e191180-2d13-11eb-115c-bbe0bf32fa71
graph = build_graph(filepath)

# ╔═╡ d1eaf140-2d24-11eb-13b6-293093398a19
	best_rsl_graph, best_rsl_graph_weight = rsl(graph, nodes(graph)[1]; is_kruskal = true)


# ╔═╡ ddb0668e-2d24-11eb-282a-ddac4d4631c9
optimal_tour_weight = 2020.0

# ╔═╡ e262f220-2d24-11eb-18da-130f7fe301dc
	rsl_relative_error = round(abs(optimal_tour_weight - best_rsl_graph_weight)/optimal_tour_weight; digits = 2)


# ╔═╡ e306ac2e-2d24-11eb-075a-cd6e94deeba1
best_rsl_graph_weight


# ╔═╡ e38c7e00-2d24-11eb-0a94-0d1dc4862d75
optimal_tour_weight


# ╔═╡ e40dbbf2-2d24-11eb-1b06-334452d27fd8
rsl_relative_error


# ╔═╡ e48cafee-2d24-11eb-1e96-61f25a383e18
	plot_graph(best_rsl_graph)

# ╔═╡ 91fb82e0-2d13-11eb-1be7-af5a1083ab20
md"""
### Showing the 1-tree  returned by the Held-Karp algorithm with bays29.tsp instance
"""

# ╔═╡ 7d5a3af0-2d24-11eb-3ca5-5754b30243b6
	best_hk_graph, best_hk_graph_weight = hk(graph; is_kruskal = false, step_size_0 = 1.0, ϵ = 10^-5)


# ╔═╡ 98c12740-2d24-11eb-3394-5790a731e05c
	 hk_relative_error = round(abs(optimal_tour_weight-best_hk_graph_weight)/optimal_tour_weight; digits = 2)


# ╔═╡ 9a5ab300-2d24-11eb-273f-b52a17bc624b
best_hk_graph_weight


# ╔═╡ a0bc9c40-2d24-11eb-06d4-15cb2cecdc0d
 hk_relative_error

# ╔═╡ 2fa3c570-2d14-11eb-1809-8187820d24c2
plot_graph(best_hk_graph)

# ╔═╡ Cell order:
# ╟─0be9edd0-fdcb-11ea-2e0b-99438dea97c4
# ╟─f37e7e90-ff88-11ea-1f2c-0ff0dac33bd4
# ╟─8ad5b910-ff8f-11ea-3835-734df59563c6
# ╠═e222eeae-fdcb-11ea-18d4-85725dcdfef7
# ╠═6af932d0-fdd1-11ea-2222-4bbb807b0db4
# ╟─11961ed0-fdcf-11ea-2e24-6fe10bafe291
# ╠═5b511e60-fdcc-11ea-2574-fd7e50a08873
# ╟─d1eaae90-fdce-11ea-38ab-070f79ea4f78
# ╟─ceccea60-2d0e-11eb-28ff-3125e7ec774c
# ╠═a43c3ca0-0591-11eb-0877-e90edd32d010
# ╟─a132cd30-0591-11eb-2517-b15c37fb4fdd
# ╠═7a83ac0e-2d08-11eb-02f4-034f05af6062
# ╠═68718350-ff8e-11ea-3da4-57a5b1b41c72
# ╟─42dd0570-0591-11eb-02d8-238f137cf89c
# ╠═472da810-fdd4-11ea-2627-af24b931e523
# ╟─145b79d0-1d5f-11eb-07cf-b55cdb5a5fc7
# ╠═5314a490-fdd3-11ea-25ef-2d1f7fc1e992
# ╟─955e1c00-0599-11eb-21fe-0db2e4a54261
# ╠═db19e470-fdd5-11ea-2975-41ca92f2cb6d
# ╟─c5acbf60-0599-11eb-2883-2d28ad492ab2
# ╠═64c277b0-04b5-11eb-0750-b320f1b4196e
# ╟─facebcc0-0599-11eb-2f85-ffa3dee4d629
# ╠═346e3af2-1d5f-11eb-1ec8-671bdd1ab73d
# ╠═58045670-1d5f-11eb-3f41-956faefc6410
# ╟─6be4617e-1d5f-11eb-2d65-f5bb4f7de7f5
# ╠═5db82560-1d5f-11eb-3cc8-3f0f181a3748
# ╟─6cca2da0-1d5f-11eb-00d3-69943a0ca28b
# ╟─b2fc2770-2d08-11eb-2fd3-5d8c609ec7ac
# ╠═fc270a0e-2d07-11eb-2f97-b3232a53acab
# ╟─2e9495d0-2d08-11eb-3dd4-87515bd8cdec
# ╟─006a3c8e-2d09-11eb-376f-abe4d1c5d527
# ╠═2e7e75c0-2d08-11eb-0b05-8f321fe2e270
# ╟─2e66f620-2d08-11eb-2e71-83633829c857
# ╟─1a185550-2d09-11eb-2a63-9701d8e89f6d
# ╠═2e4eda40-2d08-11eb-14b7-8f93dbb6f196
# ╠═2e35fb10-2d08-11eb-142d-4bde698eb6ba
# ╟─35926230-2d0e-11eb-31f0-2fb36070bd93
# ╠═2e1ca6b0-2d08-11eb-1ccc-ab1945757ee8
# ╠═2e0219d0-2d08-11eb-1c48-751a5549c05e
# ╠═b89beda2-2d12-11eb-253f-4b763a273ca6
# ╠═1e191180-2d13-11eb-115c-bbe0bf32fa71
# ╠═d1eaf140-2d24-11eb-13b6-293093398a19
# ╠═ddb0668e-2d24-11eb-282a-ddac4d4631c9
# ╠═e262f220-2d24-11eb-18da-130f7fe301dc
# ╠═e306ac2e-2d24-11eb-075a-cd6e94deeba1
# ╠═e38c7e00-2d24-11eb-0a94-0d1dc4862d75
# ╠═e40dbbf2-2d24-11eb-1b06-334452d27fd8
# ╠═e48cafee-2d24-11eb-1e96-61f25a383e18
# ╠═91fb82e0-2d13-11eb-1be7-af5a1083ab20
# ╠═e06be140-2d1d-11eb-19eb-39c368aa1849
# ╠═7d5a3af0-2d24-11eb-3ca5-5754b30243b6
# ╠═98c12740-2d24-11eb-3394-5790a731e05c
# ╠═9a5ab300-2d24-11eb-273f-b52a17bc624b
# ╠═a0bc9c40-2d24-11eb-06d4-15cb2cecdc0d
# ╠═2fa3c570-2d14-11eb-1809-8187820d24c2
