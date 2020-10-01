function test_kruskal()

    lab_nodes = [Node("a",[-0.5,0.5]),Node("b",[0.0,1.0]),Node("c",[1.0,1.0]),Node("d",[2.0,1.0]),Node("e",[2.5,0.5]),Node("f",[2.0,0.0]),Node("g",[1.0,0.0]),Node("h",[0.0,0.0]),Node("i",[0.5,0.5])]
    lab_edges = [Edge(("a","b"),4),Edge(("a","h"),8),Edge(("b","c"),8),Edge(("b","h"),11),Edge(("c","d"),7),Edge(("c","f"),4),Edge(("c","i"),2),Edge(("d","e"),9),Edge(("d","f"),14),Edge(("e","f"),10),Edge(("f","g"),2),Edge(("g","h"),1),Edge(("g","i"),6),Edge(("h","i"),7)]
    graph = Graph("laboratory graph", lab_nodes, lab_edges)
    mst = kruskal(graph)
    
    println("test if mst has the same nb_nodes as the graph")
    @test length(nodes(mst)) == nb_nodes(graph)

    println("test if mst has the same nodes as the graph")
    for node in nodes(graph)
        println("test if Node $(name(node)) is contained in mst")
        @test !isnothing(findfirst(x -> x.name == node.name, nodes(mst)))
    end

    expected_edges = [Edge(("a","b"),4),Edge(("b","c"),8),Edge(("c","d"),7),Edge(("c","f"),4),Edge(("c","i"),2),Edge(("d","e"),9),Edge(("f","g"),2),Edge(("g","h"),1)]    

    for edge in expected_edges
        println("test if edge $(edge) are the same as the expected edges")
        @test !isnothing(findfirst(x -> x.nodes == edge.nodes, edges(mst)))
    end

    @test typeof(mst) == ConnectedComponent{Vector{Float64},Int64}

    println("testing method get_components")
    c1 = ConnectedComponent("a", [Node("a", 1)], Vector{Edge{Int64}}())
    c2 = ConnectedComponent("b", [Node("b", 2), Node("c", 3)], [Edge(("b","c"), 10)])
    dict = Dict(comp.root => comp for comp in [c1,c2])
    
    @test (c2, c1) == get_components(("a","b"), dict) || (c1, c2) == get_components(("a","b"), dict)

    println("testing the merge method")
    edge_link = Edge(("a", "c"), 5)
    expected_component = ConnectedComponent("a", [Node("a", 1), Node("b", 2), Node("c", 3)], [Edge(("b","c"), 10), edge_link])
    m = merge_components!(c1, c2, edge_link) 

    println("check that the merged component has the correct attributes:")
    @test expected_component.root == m.root
    println("merged component has the expected root")
    for node in nodes(expected_component)
        @test !isnothing(findfirst(x -> x.name == node.name, nodes(m)))
    end
    println("merged component has the expected nodes")

    for edge in edges(expected_component)
        @test !isnothing(findfirst(x -> x.nodes == edge.nodes, edges(m)))
    end
    println("merged component has the expected edges")

    @test true
end

test_kruskal()