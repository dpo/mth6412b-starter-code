include("mainphase4.jl")

#bayg29 : 1610
#sol1 = hk("bayg29", raw"mth6412b-starter-code/instances/stsp/bayg29.tsp",
#           racine=:premier, algorithm=:prim, display=false, t0=20.0, maxiter=300, wmemorysize=5, σw=1.0e-3)
#sol2 = hk("bayg29", raw"mth6412b-starter-code/instances/stsp/bayg29.tsp",
#           racine=:premier, algorithm=:kruskal, display=false, t0=50.0, maxiter=300, wmemorysize=5, σw=1.0e-3)
#println("HK avec prim:\n", sol1)
#println("HK avec kruskal:\n", sol2)
#plot_tour_gap(sol1, solutiontournee)
#plot_tour_gap(sol2, solutiontournee)

#bays29 : 2020
#sol1 = hk("bays29", raw"mth6412b-starter-code/instances/stsp/bays29.tsp",
#           racine=:premier, algorithm=:prim, display=false, t0=75.0, maxiter=300, wmemorysize=5, σw=1.0e-4)
#sol2 = hk("bays29", raw"mth6412b-starter-code/instances/stsp/bays29.tsp",
#           racine=:premier, algorithm=:kruskal, display=false, t0=75.0, maxiter=300, wmemorysize=5, σw=1.0e-4)
#println("HK avec prim:\n", sol1)
#println("HK avec kruskal:\n", sol2)
#plot_tour_gap(sol1, solutiontournee)
#plot_tour_gap(sol2, solutiontournee)

#brazil58 : 25395
#sol1 = hk("brazil58", raw"mth6412b-starter-code/instances/stsp/brazil58.tsp",
#           racine=:premier, algorithm=:prim, display=false, t0=500.0, maxiter=500, wmemorysize=5, σw=1.0e-2)
#sol2 = hk("brazil58", raw"mth6412b-starter-code/instances/stsp/brazil58.tsp",
#           racine=:premier, algorithm=:kruskal, display=false, t0=500.0, maxiter=500, wmemorysize=5, σw=1.0e-2)
#println("HK avec prim:\n", sol1)
#println("HK avec kruskal:\n", sol2)
#plot_tour_gap(sol1, solutiontournee)
#plot_tour_gap(sol2, solutiontournee)

#brg180 : 1950
#sol1 = hk("brg180", raw"mth6412b-starter-code/instances/stsp/brg180.tsp",
#           racine=:premier, algorithm=:prim, display=false, t0=1.0, maxiter=300, wmemorysize=5, σw=1.0)
#sol2 = hk("brg180", raw"mth6412b-starter-code/instances/stsp/brg180.tsp",
#           racine=:premier, algorithm=:kruskal, display=false, t0=1.0, maxiter=300, wmemorysize=5, σw=1.0)
#println("HK avec prim:\n", sol1)
#println("HK avec kruskal:\n", sol2)
#plot_tour_gap(sol1, solutiontournee)
#plot_tour_gap(sol2, solutiontournee)

#dantzig42 : 699
#sol1 = hk("dantzig42", raw"mth6412b-starter-code/instances/stsp/dantzig42.tsp",
#           racine=:premier, algorithm=:prim, display=false, t0=30.0, maxiter=300, wmemorysize=5, σw=1.0e-3)
#sol2 = hk("dantzig42", raw"mth6412b-starter-code/instances/stsp/dantzig42.tsp",
#           racine=:premier, algorithm=:kruskal, display=false, t0=30.0, maxiter=300, wmemorysize=5, σw=1.0e-3)
#println("HK avec prim:\n", sol1)
#println("HK avec kruskal:\n", sol2)
#plot_tour_gap(sol1, solutiontournee)
#plot_tour_gap(sol2, solutiontournee)

#fri26 : 937
#sol1 = hk("fri26", raw"mth6412b-starter-code/instances/stsp/fri26.tsp",
#           racine=5, algorithm=:prim, display=false, t0=30.0, maxiter=300, wmemorysize=5, σw=1.0e-3)
#sol2 = hk("fri26", raw"mth6412b-starter-code/instances/stsp/fri26.tsp",
#           racine=5, algorithm=:kruskal, display=false, t0=200.0, maxiter=300, wmemorysize=5, σw=1.0e-5)
#println("HK avec prim:\n", sol1)
#println("HK avec kruskal:\n", sol2)
#plot_tour_gap(sol1, solutiontournee)
#plot_tour_gap(sol2, solutiontournee)

#gr17 : 2085
#sol1 = hk("gr17", raw"mth6412b-starter-code/instances/stsp/gr17.tsp",
#           racine=5, algorithm=:prim, display=false, t0=30.0, maxiter=300, wmemorysize=5, σw=1.0e-3)
#sol2 = hk("gr17", raw"mth6412b-starter-code/instances/stsp/gr17.tsp",
#           racine=5, algorithm=:kruskal, display=false, t0=30.0, maxiter=300, wmemorysize=5, σw=1.0e-3)
#println("HK avec prim:\n", sol1)
#println("HK avec kruskal:\n", sol2)
#plot_tour_gap(sol1, solutiontournee)
#plot_tour_gap(sol2, solutiontournee)

#gr21 : 2707
#sol1 = hk("gr21", raw"mth6412b-starter-code/instances/stsp/gr21.tsp",
#           racine=5, algorithm=:prim, display=false, t0=30.0, maxiter=300, wmemorysize=5, σw=1.0e-3)
#sol2 = hk("gr21", raw"mth6412b-starter-code/instances/stsp/gr21.tsp",
#           racine=5, algorithm=:kruskal, display=false, t0=30.0, maxiter=300, wmemorysize=5, σw=1.0e-3)
#println("HK avec prim:\n", sol1)
#println("HK avec kruskal:\n", sol2)
#plot_tour(sol1)
#plot_tour(sol2)

#gr24 : 1272
#sol1 = hk("gr24", raw"mth6412b-starter-code/instances/stsp/gr24.tsp",
#           racine=5, algorithm=:prim, display=false, t0=30.0, maxiter=300, wmemorysize=5, σw=1.0e-3)
#sol2 = hk("gr24", raw"mth6412b-starter-code/instances/stsp/gr24.tsp",
#           racine=5, algorithm=:kruskal, display=false, t0=30.0, maxiter=300, wmemorysize=5, σw=1.0e-3)
#println("HK avec prim:\n", sol1)
#println("HK avec kruskal:\n", sol2)
#plot_tour_gap(sol1, solutiontournee)
#plot_tour_gap(sol2, solutiontournee)

#gr48 : 5046
#sol1 = hk("gr48", raw"mth6412b-starter-code/instances/stsp/gr48.tsp",
#           racine=:premier, algorithm=:prim, display=false, t0=20.0, maxiter=300, wmemorysize=5, σw=1.0e-3)
#sol2 = hk("gr48", raw"mth6412b-starter-code/instances/stsp/gr48.tsp",
#           racine=:premier, algorithm=:kruskal, display=false, t0=20.0, maxiter=300, wmemorysize=5, σw=1.0e-3)
#println("HK avec prim:\n", sol1)
#println("HK avec kruskal:\n", sol2)
#plot_tour_gap(sol1, solutiontournee)
#plot_tour_gap(sol2, solutiontournee)

#gr120 : 6942
#sol1 = hk("gr120", raw"mth6412b-starter-code/instances/stsp/gr120.tsp",
#           racine=10, algorithm=:prim, display=false, t0=5.0, maxiter=500, wmemorysize=5, σw=1.0e-2)
#sol2 = hk("gr120", raw"mth6412b-starter-code/instances/stsp/gr120.tsp",
#           racine=10, algorithm=:kruskal, display=false, t0=5.0, maxiter=500, wmemorysize=5, σw=1.0e-2)
#println("HK avec prim:\n", sol1)
#println("HK avec kruskal:\n", sol2)
#plot_tour_gap(sol1, solutiontournee)
#plot_tour_gap(sol2, solutiontournee)

#hk48 : 11461
#sol1 = hk("hk48", raw"mth6412b-starter-code/instances/stsp/hk48.tsp",
#           racine=10, algorithm=:prim, display=false, t0=20.0, maxiter=300, wmemorysize=5, σw=1.0e-2)
#sol2 = hk("hk48", raw"mth6412b-starter-code/instances/stsp/hk48.tsp",
#           racine=10, algorithm=:kruskal, display=false, t0=20.0, maxiter=300, wmemorysize=5, σw=1.0e-2)
#println("HK avec prim:\n", sol1)
#println("HK avec kruskal:\n", sol2)
#plot_tour_gap(sol1, solutiontournee)
#plot_tour_gap(sol2, solutiontournee)

#pa561 : 2763
#sol1 = hk("pa561", raw"mth6412b-starter-code/instances/stsp/pa561.tsp",
#           racine=200, algorithm=:prim, display=false, t0=0.1, maxiter=300, wmemorysize=5, σw=1.0e-2)
#sol2 = hk("pa561", raw"mth6412b-starter-code/instances/stsp/pa561.tsp",
#           racine=200, algorithm=:kruskal, display=false, t0=0.1, maxiter=300, wmemorysize=5, σw=1.0e-2)
#println("HK avec prim:\n", sol1)
#println("HK avec kruskal:\n", sol2)
#plot_tour_gap(sol1, solutiontournee)
#plot_tour_gap(sol2, solutiontournee)

#swiss42 : 1273
#sol1 = hk("swiss42", raw"mth6412b-starter-code/instances/stsp/swiss42.tsp",
#           racine=:premier, algorithm=:prim, display=false, t0=5.0, maxiter=300, wmemorysize=5, σw=1.0e-3)
#sol2 = hk("swiss42", raw"mth6412b-starter-code/instances/stsp/swiss42.tsp",
#           racine=:premier, algorithm=:kruskal, display=false, t0=5.0, maxiter=300, wmemorysize=5, σw=1.0e-3)
#println("HK avec prim:\n", sol1)
#println("HK avec kruskal:\n", sol2)
#plot_tour_gap(sol1, solutiontournee)
#plot_tour_gap(sol2, solutiontournee)