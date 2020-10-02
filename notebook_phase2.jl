### A Pluto.jl notebook ###
# v0.11.14

using Markdown
using InteractiveUtils

# ╔═╡ e222eeae-fdcb-11ea-18d4-85725dcdfef7
using Pkg

# ╔═╡ 8b41a962-04b5-11eb-3418-972d158d0809
using Test

# ╔═╡ 4139d1b0-ff7b-11ea-2315-ff5faf32e879
using PlutoUI

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
begin 
	include("graph.jl")
end

# ╔═╡ 64c277b0-04b5-11eb-0750-b320f1b4196e
begin 
	include("Connected_component.jl")
end

# ╔═╡ a6e50270-04b5-11eb-2ef6-7b3c86f3c407
begin 
	include("..\\tests\\test_kruskal.jl")
end

# ╔═╡ 0be9edd0-fdcb-11ea-2e0b-99438dea97c4
md"""
## MTH6412B Project: Phase 1
"""

# ╔═╡ f37e7e90-ff88-11ea-1f2c-0ff0dac33bd4
md"""
### Authors: Monssaf Toukal (1850319) and Matteo Cacciola (2044855)
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
Pkg.add("Plots")

# ╔═╡ 32af4180-fdd1-11ea-284e-b73926bba2fb
md"""
### Building a Graph from a .tsp file
"""

# ╔═╡ 8144f8b0-ff7c-11ea-221f-9b616016224b
md"""
Implementation of connected component of a graph
"""

# ╔═╡ 94e8e520-ff7c-11ea-0b05-f98eb5cb924d
with_terminal() do
	open("Connected_component.jl","r") do file
		check=false
			for line in readlines(file)
			
				if !isempty(split(line))
					line_start=split(line)[1]
					
					if line_start=="mutable"
						check=true
					end
					if check
						println(line)
					end
					if line_start=="end"
						check=false
					end
				end
		end
	end
end

# ╔═╡ 8f72d320-04b9-11eb-345d-39aa659720d5
md"""We implemented Kruskal using two ausiliary function merge() and get_component() Here I need that the documentation is written so i can display some of it"""

# ╔═╡ afccd670-04b9-11eb-2e1b-43f890b76f42
with_terminal() do
	open("Connected_component.jl","r") do file
		check=false
			for line in readlines(file)
			
				if !isempty(split(line))
					line_start=split(line)[1]
					
					if line_start=="\"\"\"Write"
						check=true
					end
					if check
						println(line)
					end
					if line_start=="#"
						check=false
					end
				end
		end
	end
end

# ╔═╡ 3b388650-fdcb-11ea-2782-a386ba2050c2
md""" Now we build the course notes graph and we plot it"""

# ╔═╡ 2baedd10-fdcb-11ea-0fbb-b579f5848782
begin
	lab_nodes = [Node("a",[-0.5,0.5]),Node("b",[0.0,1.0]),Node("c",[1.0,1.0]),Node("d",[2.0,1.0]),Node("e",[2.5,0.5]),Node("f",[2.0,0.0]),Node("g",[1.0,0.0]),Node("h",[0.0,0.0]),Node("i",[0.5,0.5])]
    lab_edges = [Edge(("a","b"),4),Edge(("a","h"),8),Edge(("b","c"),8),Edge(("b","h"),11),Edge(("c","d"),7),Edge(("c","f"),4),Edge(("c","i"),2),Edge(("d","e"),9),Edge(("d","f"),14),Edge(("e","f"),10),Edge(("f","g"),2),Edge(("g","h"),1),Edge(("g","i"),6),Edge(("h","i"),7)]
    graph_notes = Graph("laboratory graph", lab_nodes, lab_edges)
	plot_graph(graph_notes)
end

# ╔═╡ 26fe7460-fdcb-11ea-353c-1da85f1370be
md"""Now we run Kruscal on this graph and we plot the result"""

# ╔═╡ ed44cc3e-04b6-11eb-2ce5-8fa5be74d570
begin
	mst = kruskal(graph_notes)
	plot_graph(mst)
end

# ╔═╡ 4e032f90-04b7-11eb-18cb-2bf48d66fd53
begin
with_terminal() do
		show(mst)
	end
end

# ╔═╡ f3b1e3a0-04b7-11eb-1c4c-5f56d8c0663a
md""" Here we run the unit test"""

# ╔═╡ 342a0070-04bd-11eb-1016-3be140c9bfe7
with_terminal() do
	open("..\\tests\\test_kruskal.jl","r") do file
			for line in readlines(file)
			
				if !isempty(split(line))
					line_start=split(line)[1]
					
				if line_start=="@test" ||line_start=="for" || line_start=="end"
						println(line)
					println("...")
					end
				end
		end
	end
end

# ╔═╡ f3598a70-04b7-11eb-1fec-455aa43becd4
test_kruskal()

# ╔═╡ 5911bb80-04b8-11eb-20b4-7929f4a9c2d5
md""" Now we test kruscal on various instances"""

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

# ╔═╡ 6dd74490-04b8-11eb-0632-4dd06814ea1e


# ╔═╡ Cell order:
# ╟─0be9edd0-fdcb-11ea-2e0b-99438dea97c4
# ╟─f37e7e90-ff88-11ea-1f2c-0ff0dac33bd4
# ╟─8ad5b910-ff8f-11ea-3835-734df59563c6
# ╠═e222eeae-fdcb-11ea-18d4-85725dcdfef7
# ╠═6af932d0-fdd1-11ea-2222-4bbb807b0db4
# ╠═5a358530-ff8d-11ea-073c-41440515443a
# ╟─11961ed0-fdcf-11ea-2e24-6fe10bafe291
# ╠═5b511e60-fdcc-11ea-2574-fd7e50a08873
# ╠═d1eaae90-fdce-11ea-38ab-070f79ea4f78
# ╟─32af4180-fdd1-11ea-284e-b73926bba2fb
# ╠═68718350-ff8e-11ea-3da4-57a5b1b41c72
# ╠═472da810-fdd4-11ea-2627-af24b931e523
# ╠═5314a490-fdd3-11ea-25ef-2d1f7fc1e992
# ╠═db19e470-fdd5-11ea-2975-41ca92f2cb6d
# ╠═64c277b0-04b5-11eb-0750-b320f1b4196e
# ╠═a6e50270-04b5-11eb-2ef6-7b3c86f3c407
# ╠═8b41a962-04b5-11eb-3418-972d158d0809
# ╠═4139d1b0-ff7b-11ea-2315-ff5faf32e879
# ╠═8144f8b0-ff7c-11ea-221f-9b616016224b
# ╟─94e8e520-ff7c-11ea-0b05-f98eb5cb924d
# ╠═8f72d320-04b9-11eb-345d-39aa659720d5
# ╟─afccd670-04b9-11eb-2e1b-43f890b76f42
# ╠═3b388650-fdcb-11ea-2782-a386ba2050c2
# ╠═2baedd10-fdcb-11ea-0fbb-b579f5848782
# ╠═26fe7460-fdcb-11ea-353c-1da85f1370be
# ╟─4e032f90-04b7-11eb-18cb-2bf48d66fd53
# ╠═ed44cc3e-04b6-11eb-2ce5-8fa5be74d570
# ╠═f3b1e3a0-04b7-11eb-1c4c-5f56d8c0663a
# ╟─342a0070-04bd-11eb-1016-3be140c9bfe7
# ╠═f3598a70-04b7-11eb-1fec-455aa43becd4
# ╠═5911bb80-04b8-11eb-20b4-7929f4a9c2d5
# ╠═d67d94e0-04b8-11eb-2369-2ddcdec25056
# ╠═03422720-04b9-11eb-23bf-e3385299b08f
# ╠═942960de-04ba-11eb-08a9-5bc69d9207e8
# ╠═9521556e-04ba-11eb-1886-5fb77792b5ca
# ╠═57c1bbe0-04b8-11eb-2e9b-9564cbcce0a8
# ╠═6f1039c0-04b8-11eb-37a0-5ddffdd83883
# ╠═6ecc52f0-04b8-11eb-1e34-03354dd214d1
# ╠═6e81dc70-04b8-11eb-0a7b-638519001181
# ╠═6dd74490-04b8-11eb-0632-4dd06814ea1e
