### A Pluto.jl notebook ###
# v0.11.14

using Markdown
using InteractiveUtils

# ╔═╡ e222eeae-fdcb-11ea-18d4-85725dcdfef7
using Pkg

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

# ╔═╡ 6af932d0-fdd1-11ea-2222-4bbb807b0db4
cd("D:\\tmons\\Documents\\Poly\\5_A20\\MTH6412B\\mth6412b-starter-code\\projet\\phase1")

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

# ╔═╡ 1b5a1aa0-fdd6-11ea-250a-7b25c23b9009
filename = "..\\..\\instances\\stsp\\bayg29.tsp"


# ╔═╡ 2ce12fa2-fdd8-11ea-3103-6ba0843291d4
md"""
- Here, we call the function `buil_graph` that takes a tsp file as an argument.
- The result of this function is an object `Graph` that contains all the edges and nodes given in the file
"""

# ╔═╡ f854adc0-fdd2-11ea-3d75-47c0eae37320

	graph = build_graph(filename)


# ╔═╡ a36a41e0-fdd6-11ea-17f2-d3e8fbf8e9af

show(graph)


# ╔═╡ 64e88490-fdd6-11ea-1cc6-9dd486c95201
plot_graph(filename)

# ╔═╡ 6094c560-fdd7-11ea-37fe-4744225e8b5e


# ╔═╡ 42fd1660-fdd7-11ea-1992-518877eb3ce1


# ╔═╡ 38ddaff0-fdd7-11ea-3727-9db0fd895ea0


# ╔═╡ 60567950-fdd6-11ea-348a-5f62b53a4141


# ╔═╡ 5359956e-fdd6-11ea-28a8-65796b336cc3


# ╔═╡ 2e774ae0-fdd6-11ea-01a5-753d66d90afc


# ╔═╡ 1085f940-fdcd-11ea-0fd5-5b8039b2501f


# ╔═╡ f7ba7850-fdcc-11ea-10e7-b7f986a1fa85


# ╔═╡ f5b49630-fdcc-11ea-2819-8163a7e41126


# ╔═╡ e95f3cf0-fdcc-11ea-3801-8355f7ba761d


# ╔═╡ e68a4afe-fdcc-11ea-26da-e92a883990aa


# ╔═╡ e1258670-fdcc-11ea-2694-bfb956b988cb


# ╔═╡ bb84cde0-fdcc-11ea-3ef7-b108e147eb13


# ╔═╡ a7c87770-fdcc-11ea-39be-7712085b7c3c


# ╔═╡ 8d593190-fdcc-11ea-06dd-ed3edc4ed3ba


# ╔═╡ 89d14350-fdcc-11ea-226e-094db7b46144


# ╔═╡ 4b9ede80-fdcc-11ea-36d1-a911cbe20086


# ╔═╡ 5d95376e-fdcb-11ea-22ef-dd8959d776d1


# ╔═╡ 4c48a87e-fdcb-11ea-2b65-6d696a78bdc2


# ╔═╡ 4a324ba0-fdcb-11ea-2f17-51eb9261ed00


# ╔═╡ 484fd000-fdcb-11ea-1b32-0bf0d8d93bb5


# ╔═╡ 45214c60-fdcb-11ea-1062-b92260043e28


# ╔═╡ 3cf41900-fdcb-11ea-3ba7-09c771cd6c00


# ╔═╡ 3b388650-fdcb-11ea-2782-a386ba2050c2


# ╔═╡ 391f1c30-fdcb-11ea-00bc-7bed26401ed8


# ╔═╡ 2baedd10-fdcb-11ea-0fbb-b579f5848782


# ╔═╡ 26fe7460-fdcb-11ea-353c-1da85f1370be


# ╔═╡ Cell order:
# ╠═0be9edd0-fdcb-11ea-2e0b-99438dea97c4
# ╠═e222eeae-fdcb-11ea-18d4-85725dcdfef7
# ╠═6af932d0-fdd1-11ea-2222-4bbb807b0db4
# ╠═11961ed0-fdcf-11ea-2e24-6fe10bafe291
# ╠═5b511e60-fdcc-11ea-2574-fd7e50a08873
# ╠═d1eaae90-fdce-11ea-38ab-070f79ea4f78
# ╠═32af4180-fdd1-11ea-284e-b73926bba2fb
# ╠═472da810-fdd4-11ea-2627-af24b931e523
# ╠═5314a490-fdd3-11ea-25ef-2d1f7fc1e992
# ╠═db19e470-fdd5-11ea-2975-41ca92f2cb6d
# ╠═1b5a1aa0-fdd6-11ea-250a-7b25c23b9009
# ╟─2ce12fa2-fdd8-11ea-3103-6ba0843291d4
# ╠═f854adc0-fdd2-11ea-3d75-47c0eae37320
# ╠═a36a41e0-fdd6-11ea-17f2-d3e8fbf8e9af
# ╠═64e88490-fdd6-11ea-1cc6-9dd486c95201
# ╠═6094c560-fdd7-11ea-37fe-4744225e8b5e
# ╠═42fd1660-fdd7-11ea-1992-518877eb3ce1
# ╠═38ddaff0-fdd7-11ea-3727-9db0fd895ea0
# ╠═60567950-fdd6-11ea-348a-5f62b53a4141
# ╠═5359956e-fdd6-11ea-28a8-65796b336cc3
# ╠═2e774ae0-fdd6-11ea-01a5-753d66d90afc
# ╠═1085f940-fdcd-11ea-0fd5-5b8039b2501f
# ╠═f7ba7850-fdcc-11ea-10e7-b7f986a1fa85
# ╠═f5b49630-fdcc-11ea-2819-8163a7e41126
# ╠═e95f3cf0-fdcc-11ea-3801-8355f7ba761d
# ╠═e68a4afe-fdcc-11ea-26da-e92a883990aa
# ╠═e1258670-fdcc-11ea-2694-bfb956b988cb
# ╠═bb84cde0-fdcc-11ea-3ef7-b108e147eb13
# ╠═a7c87770-fdcc-11ea-39be-7712085b7c3c
# ╠═8d593190-fdcc-11ea-06dd-ed3edc4ed3ba
# ╠═89d14350-fdcc-11ea-226e-094db7b46144
# ╠═4b9ede80-fdcc-11ea-36d1-a911cbe20086
# ╠═5d95376e-fdcb-11ea-22ef-dd8959d776d1
# ╠═4c48a87e-fdcb-11ea-2b65-6d696a78bdc2
# ╠═4a324ba0-fdcb-11ea-2f17-51eb9261ed00
# ╠═484fd000-fdcb-11ea-1b32-0bf0d8d93bb5
# ╠═45214c60-fdcb-11ea-1062-b92260043e28
# ╠═3cf41900-fdcb-11ea-3ba7-09c771cd6c00
# ╠═3b388650-fdcb-11ea-2782-a386ba2050c2
# ╠═391f1c30-fdcb-11ea-00bc-7bed26401ed8
# ╠═2baedd10-fdcb-11ea-0fbb-b579f5848782
# ╠═26fe7460-fdcb-11ea-353c-1da85f1370be
