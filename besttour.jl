include("mainphase4.jl")

#bayg29 : 1610
#graph = createGraph("graph", raw"mth6412b-starter-code/instances/stsp/bayg29.tsp")
#W1, status1, tour1 = hk!(graph, nodes(graph)[1], algorithm=:prim, display=false, t0=20.0, maxiter=300, wmemorysize=5, σw=1.0e-3)
#graph = createGraph("graph", raw"mth6412b-starter-code/instances/stsp/bayg29.tsp")
#W2, status2, tour2 = hk!(graph, nodes(graph)[1], algorithm=:kruskal, display=false, t0=20.0, maxiter=300, wmemorysize=5, σw=1.0e-3)


#bays29 : 2020
#graph = createGraph("graph", raw"mth6412b-starter-code/instances/stsp/bays29.tsp")
#W1, status1, tour1 = hk!(graph, nodes(graph)[1], algorithm=:prim, display=false, t0=75.0, maxiter=300, wmemorysize=5, σw=1.0e-4)
#graph = createGraph("graph", raw"mth6412b-starter-code/instances/stsp/bays29.tsp")
#W2, status2, tour2 = hk!(graph, nodes(graph)[1], algorithm=:kruskal, display=false, t0=75.0, maxiter=300, wmemorysize=5, σw=1.0e-4)

#brazil58 : 25395
#graph = createGraph("graph", raw"mth6412b-starter-code/instances/stsp/brazil58.tsp")
#W1, status1, tour1 = hk!(graph, nodes(graph)[1], algorithm=:prim, display=false, t0=500.0, maxiter=500, wmemorysize=5, σw=1.0e-2)
#graph = createGraph("graph", raw"mth6412b-starter-code/instances/stsp/brazil58.tsp")
#W2, status2, tour2 = hk!(graph, nodes(graph)[1], algorithm=:kruskal, display=false, t0=500.0, maxiter=500, wmemorysize=5, σw=1.0e-2)

#brg180 : 1950
#graph = createGraph("graph", raw"mth6412b-starter-code/instances/stsp/brg180.tsp")
#hk!(graph, nodes(graph)[1], algorithm=:prim, display=false, t0=1.0, maxiter=300, wmemorysize=5, σw=1.0)
#graph = createGraph("graph", raw"mth6412b-starter-code/instances/stsp/brg180.tsp")
#hk!(graph, nodes(graph)[1], algorithm=:kruskal, display=false, t0=1.0, maxiter=300, wmemorysize=5, σw=1.0)

#dantzig42 : 699
graph = createGraph("graph", raw"mth6412b-starter-code/instances/stsp/dantzig42.tsp")
W1, status1, tour1 = hk!(graph, nodes(graph)[1], algorithm=:prim, display=false, t0=30.0, maxiter=300, wmemorysize=5, σw=1.0e-3)
graph = createGraph("graph", raw"mth6412b-starter-code/instances/stsp/dantzig42.tsp")
W2, status2, tour2 = hk!(graph, nodes(graph)[1], algorithm=:kruskal, display=false, t0=30.0, maxiter=300, wmemorysize=5, σw=1.0e-3)
plot_graph2(nodes(graph), tour1)

#fri26 : 937
#graph = createGraph("graph", raw"mth6412b-starter-code/instances/stsp/fri26.tsp")
#hk!(graph, nodes(graph)[5], algorithm=:prim, display=false, t0=30.0, maxiter=300, wmemorysize=5, σw=1.0e-3)
#graph = createGraph("graph", raw"mth6412b-starter-code/instances/stsp/fri26.tsp")
#hk!(graph, nodes(graph)[5], algorithm=:kruskal, display=false, t0=30.0, maxiter=300, wmemorysize=5, σw=1.0e-3)

#gr17 : 2085
#graph = createGraph("graph", raw"mth6412b-starter-code/instances/stsp/gr17.tsp")
#W1, status1, tour1 = hk!(graph, nodes(graph)[5], algorithm=:prim, display=false, t0=30.0, maxiter=300, wmemorysize=5, σw=1.0e-3)
#graph = createGraph("graph", raw"mth6412b-starter-code/instances/stsp/gr17.tsp")
#W2, status2, tour2 = hk!(graph, nodes(graph)[5], algorithm=:kruskal, display=false, t0=30.0, maxiter=300, wmemorysize=5, σw=1.0e-3)

#gr21 : 2707
#graph = createGraph("graph", raw"mth6412b-starter-code/instances/stsp/gr21.tsp")
#hk!(graph, nodes(graph)[5], algorithm=:prim, display=false, t0=30.0, maxiter=300, wmemorysize=5, σw=1.0e-3)
#graph = createGraph("graph", raw"mth6412b-starter-code/instances/stsp/gr21.tsp")
#hk!(graph, nodes(graph)[5], algorithm=:kruskal, display=false, t0=30.0, maxiter=300, wmemorysize=5, σw=1.0e-3)

#gr24 : 1272
#graph = createGraph("graph", raw"mth6412b-starter-code/instances/stsp/gr24.tsp")
#hk!(graph, nodes(graph)[5], algorithm=:prim, display=false, t0=30.0, maxiter=300, wmemorysize=5, σw=1.0e-3)
#graph = createGraph("graph", raw"mth6412b-starter-code/instances/stsp/gr24.tsp")
#hk!(graph, nodes(graph)[5], algorithm=:kruskal, display=false, t0=30.0, maxiter=300, wmemorysize=5, σw=1.0e-3)

#gr48 : 5046
#graph = createGraph("graph", raw"mth6412b-starter-code/instances/stsp/gr48.tsp")
#hk!(graph, nodes(graph)[1], algorithm=:prim, display=false, t0=20.0, maxiter=300, wmemorysize=5, σw=1.0e-3)
#graph = createGraph("graph", raw"mth6412b-starter-code/instances/stsp/gr48.tsp")
#hk!(graph, nodes(graph)[1], algorithm=:kruskal, display=false, t0=20.0, maxiter=300, wmemorysize=5, σw=1.0e-3)

#gr120 : 6942
#graph = createGraph("graph", raw"mth6412b-starter-code/instances/stsp/gr120.tsp")
#hk!(graph, nodes(graph)[10], algorithm=:prim, display=false, t0=5.0, maxiter=500, wmemorysize=5, σw=1.0e-2)
#graph = createGraph("graph", raw"mth6412b-starter-code/instances/stsp/gr120.tsp")
#hk!(graph, nodes(graph)[10], algorithm=:kruskal, display=false, t0=5.0, maxiter=500, wmemorysize=5, σw=1.0e-2)

#hk48 : 11461
#graph = createGraph("graph", raw"mth6412b-starter-code/instances/stsp/hk48.tsp")
#hk!(graph, nodes(graph)[10], algorithm=:prim, display=false, t0=20.0, maxiter=300, wmemorysize=5, σw=1.0e-2)
#graph = createGraph("graph", raw"mth6412b-starter-code/instances/stsp/hk48.tsp")
#hk!(graph, nodes(graph)[10], algorithm=:kruskal, display=false, t0=20.0, maxiter=300, wmemorysize=5, σw=1.0e-2)

#pa561 : 2763
#graph = createGraph("graph", raw"mth6412b-starter-code/instances/stsp/pa561.tsp")
#hk!(graph, nodes(graph)[10], algorithm=:prim, display=false, t0=20.0, maxiter=100, wmemorysize=5, σw=1.0e-2)
#graph = createGraph("graph", raw"mth6412b-starter-code/instances/stsp/pa561.tsp")
#hk!(graph, nodes(graph)[10], algorithm=:kruskal, display=false, t0=20.0, maxiter=100, wmemorysize=5, σw=1.0e-2)

#swiss42 : 1273
#graph = createGraph("graph", raw"mth6412b-starter-code/instances/stsp/swiss42.tsp")
#hk!(graph, nodes(graph)[1], algorithm=:prim, display=false, t0=5.0, maxiter=300, wmemorysize=5, σw=1.0e-3)
#graph = createGraph("graph", raw"mth6412b-starter-code/instances/stsp/swiss42.tsp")
#hk!(graph, nodes(graph)[1], algorithm=:kruskal, display=false, t0=5.0, maxiter=300, wmemorysize=5, σw=1.0e-3)