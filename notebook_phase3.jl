### A Pluto.jl notebook ###
# v0.12.6

using Markdown
using InteractiveUtils

# ╔═╡ e222eeae-fdcb-11ea-18d4-85725dcdfef7
using Pkg

# ╔═╡ a43c3ca0-0591-11eb-0877-e90edd32d010
using PlutoUI

# ╔═╡ 8b41a962-04b5-11eb-3418-972d158d0809
using Test

# ╔═╡ 68718350-ff8e-11ea-3da4-57a5b1b41c72
include("exceptions.jl")

# ╔═╡ 472da810-fdd4-11ea-2627-af24b931e523
begin
	include("Node.jl")
end

# ╔═╡ 5314a490-fdd3-11ea-25ef-2d1f7fc1e992
begin
	include("Edge.jl")
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

# ╔═╡ f3598a70-04b7-11eb-1fec-455aa43becd4
begin
	with_terminal() do	
		include("..\\tests\\test_prim.jl")
	end
end

# ╔═╡ 0be9edd0-fdcb-11ea-2e0b-99438dea97c4
md"""
# MTH6412B Project: Phase 2
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
cd(joinpath(@__DIR__, "projet\\phase3"))

# ╔═╡ 5a358530-ff8d-11ea-073c-41440515443a
pwd()

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

# ╔═╡ 32af4180-fdd1-11ea-284e-b73926bba2fb
md"""
### Building a Graph from a .tsp file
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

# ╔═╡ 43ceff70-1d5f-11eb-135d-13a5c8d4210e
display("heuristics.jl")

# ╔═╡ 8b53f510-1d70-11eb-1442-11fa6eb5d4a4
md"""
### Some explanations of the heuristics (or the lack thereof)

1. Path compression:

As you can see in the file above, there is no path compression implemented. The reason is because, in some way, it is already implemented in our structure (see ConnectedComponent struct). As you can see, for each ConnectedComponent object, there is an root attribute that give us access in constant time to its root. therefore, we don't need to iterate through a path like we would in a tree. However, this structrure (ConnectedComponent) is terrible for searching since in the worst case, to find a node, we have to go through all the nodes of the graph.

2. Rank heuristic: 

We implemented the rank heuristic, but it is not useful in practice exactly because of the ConnectedComponent structure (see justification above). Using this heuristic, it will change the final root of the tree, making the final tree shorter, but we cannot exploit this shortcut because we are limited by our implementation. 

"""

# ╔═╡ 6be4617e-1d5f-11eb-2d65-f5bb4f7de7f5
display("kruskal.jl", 1, 29)

# ╔═╡ 6cca2da0-1d5f-11eb-00d3-69943a0ca28b
display("prim.jl")

# ╔═╡ 782977c0-059d-11eb-0b1c-49a27e489b9b
md""" ### Prim Algorithm
* Prim is an algorithm that returns the minimum spanning tree of a given undirected fully connected graph
* it uses two auxiliary functions: 
1. **`find_edge(...)`** $\rightarrow$ returns a tuple and an edge
"""

# ╔═╡ 3780d0de-059f-11eb-2bf9-8b71114fd0cf
md"""
#### Testing Kruskal

Here are some tests of our implementation of Kruskal

1. The first test will use the graph given in the 3rd slide of the pdf *mst-handout.pdf*


2. We will also show the different unit tests implemented to make sure that Kruskal works as designed


3. There will be some examples of Kruskal for different symmetric instances given. 

"""

# ╔═╡ 3b388650-fdcb-11ea-2782-a386ba2050c2
md""" __We build the course notes graph and we plot it__"""

# ╔═╡ 2baedd10-fdcb-11ea-0fbb-b579f5848782
begin
	lab_nodes = [Node("a",[-0.5,0.5]),Node("b",[0.0,1.0]),Node("c",[1.0,1.0]),Node("d",[2.0,1.0]),Node("e",[2.5,0.5]),Node("f",[2.0,0.0]),Node("g",[1.0,0.0]),Node("h",[0.0,0.0]),Node("i",[0.5,0.5])]
    lab_edges = [Edge(("a","b"),4),Edge(("a","h"),8),Edge(("b","c"),8),Edge(("b","h"),11),Edge(("c","d"),7),Edge(("c","f"),4),Edge(("c","i"),2),Edge(("d","e"),9),Edge(("d","f"),14),Edge(("e","f"),10),Edge(("f","g"),2),Edge(("g","h"),1),Edge(("g","i"),6),Edge(("h","i"),7)]
    graph_notes = Graph("laboratory graph", lab_nodes, lab_edges)
	plot_graph(graph_notes)
end

# ╔═╡ 26fe7460-fdcb-11ea-353c-1da85f1370be
md"""
**Now we run Prim on this graph and we plot the result**
"""

# ╔═╡ 4e032f90-04b7-11eb-18cb-2bf48d66fd53
begin
	mst_prim, prim_weight = prim(graph_notes)
	with_terminal() do
		show(mst_prim, graph_notes)
		println("prim_weight: ", prim_weight)
	end
end

# ╔═╡ e9e61cd0-1d60-11eb-158c-13afbf9b69f9
md"""
**Note:** There is a step  where we have two minimal edges that connect to a node that is not in the current solution. Therefore, that is why we get a different minimal spanning tree than with kruskal. They still have the same total weight.
"""

# ╔═╡ ed44cc3e-04b6-11eb-2ce5-8fa5be74d570
begin
	plot_graph(mst_prim)
end

# ╔═╡ f3b1e3a0-04b7-11eb-1c4c-5f56d8c0663a
md""" **Here we display and run the unit tests for the Prim algorithm**"""

# ╔═╡ ab21f052-059b-11eb-231a-ddb82d46d137
begin 
	display("..\\tests\\test_prim.jl")
end

# ╔═╡ 7b4110a0-05a0-11eb-3409-f924951ba14a
md"""**Running unit tests for Prim**"""

# ╔═╡ 463ca740-1d63-11eb-14f8-95eed0b2e9ac
md"""## Rank Heuristics Proof
	
Let S be a set of disjoint forests. We will show that the rank of any node after the merge of all the elements of S will be less or equal than $\lfloor\log_2 |S|\rfloor$:

Proof:

 * We will prove the thesis using the root node as it has the highest rank of all the nodes.

* We will do this by induction using the cardinality of S. 

1. base case: 
	
If $|S| = 1$ or $|S| = 2$, the statement is obvious and the inequality is valid.


2. Induction

let $r(S)$ be the rank of the root of the final component when all elements of S are merged.

Suppose that if $|S| = k$ such that $k \leq n$ for $k,n \in \mathbf{N}$

then $r(S) \leq \log_2 |k|$.

Now, suppose that $|S| = n + 1$

let $a, b$ be the two final components lefts before the last merging step. 

Let $S_1, S_2$ such that $S_1 \cup S_2 = S$ be the two sets such that $a$ is the result of the merging of $S_1$ and $b$ is the result of the merging of $S_2$.

Since $|S_1| < n+1$ and $|S_2| < n+1$, we can use the inductive hypothesis.

Therefore, $r(S) \leq \max\{\max\{\log_2(|S_1|), \log_2(|S_2|)\}, \log_2(\frac{n+1}{2}) + 1\}$ where $|S_1| + |S_2| = n + 1$

$\max\{\log_2(|S_1|), \log_2(|S_2|)\} \leq \log_2(n) \leq \log_2(n+1)$

$\log_2(\frac{n+1}{2}) + 1 = \log_2(n+1) - 1 + 1 = \log_2(n+1)$

Therefore, $r(S) \leq \log_2(n+1)$

Since the $r(S)$ is a positive integer, we also have  $r \leq \lfloor\log_2 |n+1|\rfloor$



"""

# ╔═╡ Cell order:
# ╟─0be9edd0-fdcb-11ea-2e0b-99438dea97c4
# ╟─f37e7e90-ff88-11ea-1f2c-0ff0dac33bd4
# ╟─8ad5b910-ff8f-11ea-3835-734df59563c6
# ╠═e222eeae-fdcb-11ea-18d4-85725dcdfef7
# ╠═6af932d0-fdd1-11ea-2222-4bbb807b0db4
# ╠═5a358530-ff8d-11ea-073c-41440515443a
# ╟─11961ed0-fdcf-11ea-2e24-6fe10bafe291
# ╠═5b511e60-fdcc-11ea-2574-fd7e50a08873
# ╟─d1eaae90-fdce-11ea-38ab-070f79ea4f78
# ╠═a43c3ca0-0591-11eb-0877-e90edd32d010
# ╟─a132cd30-0591-11eb-2517-b15c37fb4fdd
# ╟─32af4180-fdd1-11ea-284e-b73926bba2fb
# ╠═68718350-ff8e-11ea-3da4-57a5b1b41c72
# ╟─42dd0570-0591-11eb-02d8-238f137cf89c
# ╠═472da810-fdd4-11ea-2627-af24b931e523
# ╠═145b79d0-1d5f-11eb-07cf-b55cdb5a5fc7
# ╠═5314a490-fdd3-11ea-25ef-2d1f7fc1e992
# ╟─955e1c00-0599-11eb-21fe-0db2e4a54261
# ╠═db19e470-fdd5-11ea-2975-41ca92f2cb6d
# ╟─c5acbf60-0599-11eb-2883-2d28ad492ab2
# ╠═64c277b0-04b5-11eb-0750-b320f1b4196e
# ╟─facebcc0-0599-11eb-2f85-ffa3dee4d629
# ╠═346e3af2-1d5f-11eb-1ec8-671bdd1ab73d
# ╠═43ceff70-1d5f-11eb-135d-13a5c8d4210e
# ╠═8b53f510-1d70-11eb-1442-11fa6eb5d4a4
# ╠═58045670-1d5f-11eb-3f41-956faefc6410
# ╟─6be4617e-1d5f-11eb-2d65-f5bb4f7de7f5
# ╠═5db82560-1d5f-11eb-3cc8-3f0f181a3748
# ╟─6cca2da0-1d5f-11eb-00d3-69943a0ca28b
# ╠═8b41a962-04b5-11eb-3418-972d158d0809
# ╠═782977c0-059d-11eb-0b1c-49a27e489b9b
# ╟─3780d0de-059f-11eb-2bf9-8b71114fd0cf
# ╟─3b388650-fdcb-11ea-2782-a386ba2050c2
# ╠═2baedd10-fdcb-11ea-0fbb-b579f5848782
# ╟─26fe7460-fdcb-11ea-353c-1da85f1370be
# ╠═4e032f90-04b7-11eb-18cb-2bf48d66fd53
# ╟─e9e61cd0-1d60-11eb-158c-13afbf9b69f9
# ╠═ed44cc3e-04b6-11eb-2ce5-8fa5be74d570
# ╠═f3b1e3a0-04b7-11eb-1c4c-5f56d8c0663a
# ╠═ab21f052-059b-11eb-231a-ddb82d46d137
# ╠═7b4110a0-05a0-11eb-3409-f924951ba14a
# ╠═f3598a70-04b7-11eb-1fec-455aa43becd4
# ╠═463ca740-1d63-11eb-14f8-95eed0b2e9ac
