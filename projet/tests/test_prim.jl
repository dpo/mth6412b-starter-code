function test_prim()

    println("testing prim on the graph given in the notes and comparing it to kruskal: ")

    lab_nodes = [Node("a",[-0.5,0.5]),Node("b",[0.0,1.0]),Node("c",[1.0,1.0]),Node("d",[2.0,1.0]),Node("e",[2.5,0.5]),Node("f",[2.0,0.0]),Node("g",[1.0,0.0]),Node("h",[0.0,0.0]),Node("i",[0.5,0.5])]
    lab_edges = [Edge(("a","b"),4),Edge(("a","h"),8),Edge(("b","c"),8),Edge(("b","h"),11),Edge(("c","d"),7),Edge(("c","f"),4),Edge(("c","i"),2),Edge(("d","e"),9),Edge(("d","f"),14),Edge(("e","f"),10),Edge(("f","g"),2),Edge(("g","h"),1),Edge(("g","i"),6),Edge(("h","i"),7)]
    graph = Graph("laboratory graph", lab_nodes, lab_edges)
    prim_mst, prim_weight = prim(graph)
    
    mst_kruskal, kruskal_weight = kruskal(graph)


    println("test if mst has the same nb_nodes as the graph")
    @test length(nodes(mst)) == nb_nodes(graph)

    println("test if mst has the same nodes as the graph")
    for node in nodes(graph)
        println("test if Node $(name(node)) is contained in mst")
        @test !isnothing(findfirst(x -> x.name == node.name, nodes(mst)))
    end

    println("compare prim and kruskal using graph given in notes: ")

    @test kruskal_weight == prim_weight

    instance_directory = joinpath(@__DIR__, "instances")
    for (root, dirs, files) in walkdir(instance_directory)
        for dir in dirs
            if dir == "atsp"
                continue
            end
            for file in files
                filename = joinpath(root, dir, file)
                graph = build_graph(filename)
                prim_mst, prim_weight = prim(graph)
                mst_kruskal, kruskal_weight = kruskal(graph)
                @test kruskal_weight == prim_weight
            end
    end
end

test_prim()