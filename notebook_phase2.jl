### A Pluto.jl notebook ###
# v0.11.14

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
	include("Connected_component.jl")
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
cd(joinpath(@__DIR__, "projet\\phase2"))

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

# ╔═╡ 8461cff0-0599-11eb-0461-1bbbd9bb87ce
display("Node.jl")

# ╔═╡ 955e1c00-0599-11eb-21fe-0db2e4a54261
display("Edge.jl")

# ╔═╡ c5acbf60-0599-11eb-2883-2d28ad492ab2
display("graph.jl",1,34)

# ╔═╡ facebcc0-0599-11eb-2f85-ffa3dee4d629
display("Connected_component.jl", 1, 18)

# ╔═╡ 782977c0-059d-11eb-0b1c-49a27e489b9b
md""" ### Kruskal Algorithm
* Kruskal is an algorithm that returns the minimum spanning tree of a given undirected fully connected graph
* it uses two auxiliary functions: 
1. **`get_components(...)`** $\rightarrow$ returns two components connected by a given edge
2. **`merge_components!(...)`** $\rightarrow$ returns the result of a merge (i.e a connection) of two connected components of the given graph
"""

# ╔═╡ 8f72d320-04b9-11eb-345d-39aa659720d5
display("Connected_component.jl", 21, 47)

# ╔═╡ d94dfa72-059e-11eb-3bb1-5911eb41cd97
display("Connected_component.jl", 49, 65)

# ╔═╡ e9e3e390-059e-11eb-33b0-0d00bad34395
display("Connected_component.jl", 71, 83)

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
**Now we run Kruskal on this graph and we plot the result**
"""

# ╔═╡ ed44cc3e-04b6-11eb-2ce5-8fa5be74d570
begin
	mst = kruskal(graph_notes)
	plot_graph(mst)
end

# ╔═╡ 4e032f90-04b7-11eb-18cb-2bf48d66fd53
begin
with_terminal() do
		show(mst, graph_notes)
	end
end

# ╔═╡ f3b1e3a0-04b7-11eb-1c4c-5f56d8c0663a
md""" **Here we display and run the unit tests for the Kruskal algorithm**"""

# ╔═╡ ab21f052-059b-11eb-231a-ddb82d46d137
begin 
	display("..\\tests\\test_kruskal.jl")
end

# ╔═╡ 7b4110a0-05a0-11eb-3409-f924951ba14a
md"""**Running unit tests for Kruskal**"""

# ╔═╡ f3598a70-04b7-11eb-1fec-455aa43becd4
begin
	with_terminal() do	
		include("..\\tests\\test_kruskal.jl")
	end
end

# ╔═╡ 5911bb80-04b8-11eb-20b4-7929f4a9c2d5
md""" **Now we test kruskal on various instances (symmetric)**"""

# ╔═╡ d67d94e0-04b8-11eb-2369-2ddcdec25056
filename1 = "..\\..\\instances\\stsp\\bayg29.tsp"

# ╔═╡ 03422720-04b9-11eb-23bf-e3385299b08f
begin
	graph_bayg29=build_graph(filename1)
	mst_bayg29 = kruskal(graph_bayg29)
	plot_graph(mst_bayg29)
end

# ╔═╡ 942960de-04ba-11eb-08a9-5bc69d9207e8
filename2 = "..\\..\\instances\\stsp\\dantzig42.tsp"

# ╔═╡ 9521556e-04ba-11eb-1886-5fb77792b5ca
begin
	graph_dantzing42=build_graph(filename2)
	mst_dantzing42 = kruskal(graph_dantzing42)
	plot_graph(mst_dantzing42)
end

# ╔═╡ 57c1bbe0-04b8-11eb-2e9b-9564cbcce0a8
filename3 = "..\\..\\instances\\stsp\\gr17.tsp"

# ╔═╡ 6f1039c0-04b8-11eb-37a0-5ddffdd83883
begin
	graph_gr17=build_graph(filename3)
	mst_gr17 = kruskal(graph_gr17)
	plot_graph(mst_gr17)
end

# ╔═╡ 6ecc52f0-04b8-11eb-1e34-03354dd214d1
filename4 = "..\\..\\instances\\stsp\\hk48.tsp"

# ╔═╡ 6e81dc70-04b8-11eb-0a7b-638519001181
begin
	graph_hk48=build_graph(filename4)
	mst_hk48 = kruskal(graph_hk48)
	plot_graph(mst_hk48)
end

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
# ╟─8461cff0-0599-11eb-0461-1bbbd9bb87ce
# ╠═5314a490-fdd3-11ea-25ef-2d1f7fc1e992
# ╟─955e1c00-0599-11eb-21fe-0db2e4a54261
# ╠═db19e470-fdd5-11ea-2975-41ca92f2cb6d
# ╟─c5acbf60-0599-11eb-2883-2d28ad492ab2
# ╠═64c277b0-04b5-11eb-0750-b320f1b4196e
# ╟─facebcc0-0599-11eb-2f85-ffa3dee4d629
# ╠═8b41a962-04b5-11eb-3418-972d158d0809
# ╠═782977c0-059d-11eb-0b1c-49a27e489b9b
# ╟─8f72d320-04b9-11eb-345d-39aa659720d5
# ╟─d94dfa72-059e-11eb-3bb1-5911eb41cd97
# ╠═e9e3e390-059e-11eb-33b0-0d00bad34395
# ╟─3780d0de-059f-11eb-2bf9-8b71114fd0cf
# ╠═3b388650-fdcb-11ea-2782-a386ba2050c2
# ╟─2baedd10-fdcb-11ea-0fbb-b579f5848782
# ╠═26fe7460-fdcb-11ea-353c-1da85f1370be
# ╟─4e032f90-04b7-11eb-18cb-2bf48d66fd53
# ╟─ed44cc3e-04b6-11eb-2ce5-8fa5be74d570
# ╠═f3b1e3a0-04b7-11eb-1c4c-5f56d8c0663a
# ╟─ab21f052-059b-11eb-231a-ddb82d46d137
# ╟─7b4110a0-05a0-11eb-3409-f924951ba14a
# ╟─f3598a70-04b7-11eb-1fec-455aa43becd4
# ╟─5911bb80-04b8-11eb-20b4-7929f4a9c2d5
# ╠═d67d94e0-04b8-11eb-2369-2ddcdec25056
# ╟─03422720-04b9-11eb-23bf-e3385299b08f
# ╠═942960de-04ba-11eb-08a9-5bc69d9207e8
# ╟─9521556e-04ba-11eb-1886-5fb77792b5ca
# ╠═57c1bbe0-04b8-11eb-2e9b-9564cbcce0a8
# ╟─6f1039c0-04b8-11eb-37a0-5ddffdd83883
# ╠═6ecc52f0-04b8-11eb-1e34-03354dd214d1
# ╟─6e81dc70-04b8-11eb-0a7b-638519001181
