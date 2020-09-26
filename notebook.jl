### A Pluto.jl notebook ###
# v0.11.14

using Markdown
using InteractiveUtils

# ╔═╡ e222eeae-fdcb-11ea-18d4-85725dcdfef7
using Pkg

# ╔═╡ 4139d1b0-ff7b-11ea-2315-ff5faf32e879
using PlutoUI

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

# ╔═╡ 0be9edd0-fdcb-11ea-2e0b-99438dea97c4
md"""
## MTH6412B Project: Phase 1
"""

# ╔═╡ f37e7e90-ff88-11ea-1f2c-0ff0dac33bd4
md"""
### Authors: Monssaf Toukal and Matteo Cacciola
"""

# ╔═╡ 6af932d0-fdd1-11ea-2222-4bbb807b0db4
cd("C:\\Users\\Mattheu\\Documents\\mth6412b-starter-code\\projet\\phase1")

# ╔═╡ 11961ed0-fdcf-11ea-2e24-6fe10bafe291
pwd()

# ╔═╡ 5b511e60-fdcc-11ea-2574-fd7e50a08873
Pkg.activate("./mth6412b")

# ╔═╡ d1eaae90-fdce-11ea-38ab-070f79ea4f78
Pkg.add("Plots")

# ╔═╡ 32af4180-fdd1-11ea-284e-b73926bba2fb
md"""
### Building a Graph from a .tsp file
"""

# ╔═╡ 8144f8b0-ff7c-11ea-221f-9b616016224b
md"""
Implementation of edges
"""

# ╔═╡ 94e8e520-ff7c-11ea-0b05-f98eb5cb924d
with_terminal() do
	open("edge.jl","r") do file
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

# ╔═╡ 93e8dd70-ff80-11ea-0fbb-67f0e956d0b7
md"""
Implementation of graph
"""

# ╔═╡ e50f2a80-ff7e-11ea-1596-5107c15c8f2b
with_terminal() do
	open("graph.jl","r") do file
		check=false
			for line in readlines(file)
			
				if !isempty(split(line))
					line_start=split(line)[1]
					
					if line_start=="mutable"
						check=true
					end
					if check==true
						println(line)
					end
					if line_start=="end"
						check=false
					end
				end
		end
	end
end

# ╔═╡ 9e923460-ff80-11ea-07e8-71e793fc5500
md"""
Show now is extended to correctly display edges and the user can add edges to the graph using the function add_edge!
"""

# ╔═╡ fe6d7590-ff7e-11ea-2d2b-d7c1e708b4cc
with_terminal() do
	n1=Node("1",[1.0,2.0])
	n2=Node("2",[2.0,1.0])
	n3=Node("3",[3.0,2.0])
	e1=Edge(("1","2"),3.4)
	g=Graph("example",[n1,n2,n3],[e1])
	show(g)
	add_edge!(g,Edge(("2","3"),1.2))
	show(g)
end

# ╔═╡ 1b5a1aa0-fdd6-11ea-250a-7b25c23b9009
filename = "..\\..\\instances\\stsp\\gr17.tsp"


# ╔═╡ cc09c2f0-ff80-11ea-23f0-31188a8451d8
md"""
The function read_edges now does correctly reas all the weights of the edges and it sotres them in a dictionary wehre the keys are the pairs of the node names the the edge connects and the values are the weight of the edges
"""

# ╔═╡ f60a6fb0-ff7f-11ea-0000-339b66ad54dc
with_terminal() do
	edges=read_edges(read_header(filename),filename)
	println(edges)
end

# ╔═╡ 2ce12fa2-fdd8-11ea-3103-6ba0843291d4
md"""
- Here, we call the function `buil_graph` that takes a tsp file as an argument.
- The result of this function is an object `Graph` that contains all the edges and nodes given in the file
"""

# ╔═╡ f854adc0-fdd2-11ea-3d75-47c0eae37320

	graph = build_graph(filename)


# ╔═╡ a36a41e0-fdd6-11ea-17f2-d3e8fbf8e9af

with_terminal() do
show(graph)
end


# ╔═╡ 57bd07f0-ff89-11ea-0e15-b1ab5d514d1e
md"""
Lastly we can plot the graph
"""

# ╔═╡ 64e88490-fdd6-11ea-1cc6-9dd486c95201
plot_graph(graph)

# ╔═╡ 3b388650-fdcb-11ea-2782-a386ba2050c2


# ╔═╡ 2baedd10-fdcb-11ea-0fbb-b579f5848782


# ╔═╡ 26fe7460-fdcb-11ea-353c-1da85f1370be


# ╔═╡ Cell order:
# ╟─0be9edd0-fdcb-11ea-2e0b-99438dea97c4
# ╟─f37e7e90-ff88-11ea-1f2c-0ff0dac33bd4
# ╠═e222eeae-fdcb-11ea-18d4-85725dcdfef7
# ╠═6af932d0-fdd1-11ea-2222-4bbb807b0db4
# ╟─11961ed0-fdcf-11ea-2e24-6fe10bafe291
# ╠═5b511e60-fdcc-11ea-2574-fd7e50a08873
# ╠═d1eaae90-fdce-11ea-38ab-070f79ea4f78
# ╟─32af4180-fdd1-11ea-284e-b73926bba2fb
# ╠═472da810-fdd4-11ea-2627-af24b931e523
# ╠═5314a490-fdd3-11ea-25ef-2d1f7fc1e992
# ╠═db19e470-fdd5-11ea-2975-41ca92f2cb6d
# ╠═4139d1b0-ff7b-11ea-2315-ff5faf32e879
# ╟─8144f8b0-ff7c-11ea-221f-9b616016224b
# ╟─94e8e520-ff7c-11ea-0b05-f98eb5cb924d
# ╟─93e8dd70-ff80-11ea-0fbb-67f0e956d0b7
# ╟─e50f2a80-ff7e-11ea-1596-5107c15c8f2b
# ╟─9e923460-ff80-11ea-07e8-71e793fc5500
# ╠═fe6d7590-ff7e-11ea-2d2b-d7c1e708b4cc
# ╟─1b5a1aa0-fdd6-11ea-250a-7b25c23b9009
# ╟─cc09c2f0-ff80-11ea-23f0-31188a8451d8
# ╠═f60a6fb0-ff7f-11ea-0000-339b66ad54dc
# ╟─2ce12fa2-fdd8-11ea-3103-6ba0843291d4
# ╠═f854adc0-fdd2-11ea-3d75-47c0eae37320
# ╠═a36a41e0-fdd6-11ea-17f2-d3e8fbf8e9af
# ╟─57bd07f0-ff89-11ea-0e15-b1ab5d514d1e
# ╠═64e88490-fdd6-11ea-1cc6-9dd486c95201
# ╠═3b388650-fdcb-11ea-2782-a386ba2050c2
# ╠═2baedd10-fdcb-11ea-0fbb-b579f5848782
# ╠═26fe7460-fdcb-11ea-353c-1da85f1370be
