### A Pluto.jl notebook ###
# v0.16.1

using Markdown
using InteractiveUtils

# ╔═╡ bc370dd0-1be8-11ec-07f6-e7ed296b0324
md"# Assignment 1

## Class??
## Prof. Orban
Group:
* Mozhgan 
* Farhad Rahbarnia 

This document holds the summary of the steps and outputs of Phase 1 of the class project.



[Code to Github: https://github.com/farhadrclass/mth6412b-starter-code]( https://github.com/farhadrclass/mth6412b-starter-code )


"

# ╔═╡ 4dc27f4d-7c9c-4d93-b3c3-eb7cd5d73413
md"
# Summary of What we did?

1. Retrieve the code for phase 1 from the course website. You will find there a
Node for the nodes of a graph and Graph for the graph itself. We also provide
also a set of functions that read the files in TSPLib format. We limit ourselves here to
symmetric problems whose weights are given in EXPLICIT format.

2. Propose an Edge type to represent the edges of a graph.

3. Extend the Graph type so that a graph contains its edges. We limit ourselves here to non oriented graphs. The user must be able to add one edge at a time to a graph.

4. Extend the show method of a Graph object so that the edges of the graph are also displayed.
 
5. Extend the read_edges() function of read_stsp.jl to read the weights of the edges (they are currently ignored). 

6. Provide a main program that reads a symmetric TSP instance whose weights are given in EXPLICIT format and builds a corresponding Graph object.

7. Your code should be available on your fork of the startup repository on Github in a
branch named phase1 . Indicate its address in your report. In addition, your report should
demonstrate the use of your main program and its results.




"

# ╔═╡ f05adbc6-d170-49ad-a079-5748d314db4c
md"

# edge.jl

Here is the code snip which we included here :

```julia


import Base.show
include(\"node.jl\")

\"\"\" Abstract type from which other edge types will be derived.
\"\"\"
abstract type AbstractEdge{K} end

\"\"\"Type to representant the Edges of a graph

Exemple:

    #Old  edge1 = Edge(\"TO-MTL\",(1,2), 100 )
    #edge1= Edge((1,2), 100 ) 
    edge1= Edge(node1, node2, 50.1)

 TODO I will try to break the edge to edgeNode1 , edgeNode2 later to make the reading them faster

\"\"\"
mutable struct Edge{K} <: AbstractEdge{K}
  node1::Node{K} # start node
  node2::Node{K} # Finish node
  weight::Float64
end



edgeStart(edge::AbstractEdge) = data(edge.node1)

edgeEnd(edge::AbstractEdge) = data(edge.node2)

\"\"\"Renvoie les données contenues dans le noeud.
EN: Returns the weight contained in the edge \"\"\"
weight(edge::AbstractEdge) = edge.weight

\"\"\"Affiche un noeud.
EN: present the edge 
\"\"\"
# Fix this later
function show(edge::AbstractEdge)
  println(\"Starting Point \",edgeStart(edge) ,\", EndNode \", edgeEnd(edge), \", weight: \", weight(edge))
end



```


"

# ╔═╡ 65a51afa-6063-43b6-bca4-4a025cfc722e
md"
# read_stsp.jl
We added a Weight to this here and added to tuple of edges 

```julia
 while n_data > 0
          n_on_this_line = min(n_to_read, n_data)
          for j = start : start + n_on_this_line - 1
            weight = parse(Float64, data[j+1])
            n_edges = n_edges + 1
            if edge_weight_format in [\"UPPER_ROW\", \"LOWER_COL\"]
              edge = (k+1, i+k+2, weight)
            elseif edge_weight_format in [\"UPPER_DIAG_ROW\", \"LOWER_DIAG_COL\"]
              edge = (k+1, i+k+1, weight)
            elseif edge_weight_format in [\"UPPER_COL\", \"LOWER_ROW\"]
              edge = (i+k+2, k+1, weight)
            elseif edge_weight_format in [\"UPPER_DIAG_COL\", \"LOWER_DIAG_ROW\"]
              edge = (i+1, k+1, weight)
            elseif edge_weight_format == \"FULL_MATRIX\"
              edge = (k+1, i+1, weight)
            else
              warn(\"Unknown format - function read_edges\")
            end

```
"

# ╔═╡ 3687542f-1a0e-4082-9bdd-1c2f8c0abcaf
md"
# graph.jl
For this file, we added a edge varible
```julia
import Base.show

\"\"\"Type abstrait dont d'autres types de graphes dériveront.
EN: Abstract type from which other types of graphs will be derived.
\"\"\"
abstract type AbstractGraph{T, K} end

\"\"\"Type representant un graphe comme un ensemble de noeuds.
En: Type representing a graph as a set of nodes.

Exemple :

    node1 = Node(\"Joe\", 3.14)
    node2 = Node(\"Steve\", exp(1))
    node3 = Node(\"Jill\", 4.12)

    edge1= Edge(node1, node2, 50.1)
    edge2= Edge(node2, node3, 50.1)


    G = Graph(\"Ick\", [node1, node2, node3], [edge1, edge2])

Attention, tous les noeuds doivent avoir des données de même type.
EN: Attention, all nodes must have data of the same type.
\"\"\"
mutable struct Graph{T, K} <: AbstractGraph{T,K}
  name::String
  nodes::Vector{Node{T}}
  edges::Vector{Edge{K}}  
end

\"\"\"Ajoute un noeud au graphe.
EN: This Function adds a note to the graph
\"\"\"
function add_node!(graph::Graph{T,K}, node::Node{T}) where {T, K}
  push!(graph.nodes, node)
  graph
end

# on présume que tous les graphes dérivant d'AbstractGraph
# posséderont des champs `name` et `nodes`.

# it is assumed that all graphs derived from AbstractGraph
# will have `name` and `nodes` fields.
\"\"\" This Function adds a Edge to the graph
\"\"\"
function add_edge!(graph::Graph{T,K}, edge::Edge{K}) where {T, K}
  push!(graph.edges, edge)
  graph
end

\"\"\"Renvoie le nom du graphe.
EN: Returns the name of the graph
\"\"\"
name(graph::AbstractGraph) = graph.name

\"\"\"Renvoie la liste des noeuds du graphe.
EN: Retuens a list of nodes of the graph
\"\"\"
nodes(graph::AbstractGraph) = graph.nodes

\"\"\"Renvoie le nombre de noeuds du graphe.
EN: Returns a size or number of nodes of a graph
\"\"\"
nb_nodes(graph::AbstractGraph) = length(graph.nodes)


\"\"\"
Return the graph edges 
\"\"\"
edges(graph::AbstractGraph) = graph.edges

\"\"\"
Number of Edges
\"\"\"
nb_edges(graph::AbstractGraph) = length(graph.edges)




\"\"\"Affiche un graphe
EN: Display a graph
\"\"\"
function show(graph::Graph)
  println(\"Graph \", name(graph), \" has \", nb_nodes(graph), \" nodes.\")
  println(\"Graph \", name(graph), \" has \", nb_edges(graph), \" Edges.\")

  for node in nodes(graph)
    show(node)
  end
  # for the edges
  for edge in edges(graph)
    show(edge)
  end  
end

```

"

# ╔═╡ 3b377075-470a-498e-88e3-728879906f78
md"
# main.ji
This files, read a stsp file, create edges and Nodes, then create and show the graph

```julia 
\"\"\"
This program reads a symmetric TSP instance whose weights are given in EXPLICIT format and builds a corresponding Graph object.
\"\"\"

# Import the other files    
include(\"node.jl\")
include(\"edge.jl\")
include(\"graph.jl\")
include(\"read_stsp.jl\")


# read the graph from the file 
cd(\"instances\\stsp\\ \") # go to the file for data
graphName = \"gr17\"  # this name used for name of the graph
fileName = string(graphName,\".tsp\")
graph_nodes, graph_edges = read_stsp(fileName)


# nodesList = Array{Node, 1}(undef, length(graph_edges)) # or `Vector{Node}(undef, length(graph_edges))`
nodesList = Node{Int64}[]

for k=1:length(graph_edges)
    if (length(graph_nodes) > 0) # check to see if the name is assigned in the TSP file, if not we do something else 
        node_buff = Node(graph_nodes[k][1], graph_nodes[k][2])
    else
        node_buff = Node(string(k), k ) #name is the same as we assign it 
    end
    push!(nodesList,node_buff)
end

 # edge positions
 # go through the edge list and create the edges of the graph


edgesList=Edge{Int64}[]
 for k = 1 : length(graph_edges)
    for j = 1 : length(graph_edges[k])
        edge_buff=Edge(nodesList[k], nodesList[j], graph_edges[k][j][2])
        push!(edgesList, edge_buff)
    end
  end


# create a graph using data types
G = Graph(graphName, nodesList, edgesList)
show(G)

```


"

# ╔═╡ b1130557-6671-44bb-9354-34a0acd46ca1
md"
# Output of the system 

```console
Graph gr17 has 17 nodes.
Graph gr17 has 153 edges.
Node 1, data: 1
Node 2, data: 2
Node 3, data: 3
Node 4, data: 4
Node 5, data: 5
Node 6, data: 6
Node 7, data: 7
Node 8, data: 8
Node 9, data: 9
Node 10, data: 10
Node 11, data: 11
Node 12, data: 12
Node 13, data: 13
Node 14, data: 14
Node 15, data: 15
Node 16, data: 16
Node 17, data: 17
Starting Point 1, EndNode 1, weight: 0.0
Starting Point 2, EndNode 1, weight: 633.0
Starting Point 2, EndNode 2, weight: 0.0
Starting Point 3, EndNode 1, weight: 257.0
Starting Point 3, EndNode 2, weight: 390.0
Starting Point 3, EndNode 3, weight: 0.0
Starting Point 4, EndNode 1, weight: 91.0
Starting Point 4, EndNode 2, weight: 661.0
Starting Point 4, EndNode 3, weight: 228.0
Starting Point 4, EndNode 4, weight: 0.0
Starting Point 5, EndNode 1, weight: 412.0
Starting Point 5, EndNode 2, weight: 227.0
Starting Point 5, EndNode 3, weight: 169.0
Starting Point 5, EndNode 4, weight: 383.0
Starting Point 5, EndNode 5, weight: 0.0
Starting Point 6, EndNode 1, weight: 150.0
Starting Point 6, EndNode 2, weight: 488.0
Starting Point 6, EndNode 3, weight: 112.0
Starting Point 6, EndNode 4, weight: 120.0
Starting Point 6, EndNode 5, weight: 267.0
Starting Point 6, EndNode 6, weight: 0.0
Starting Point 7, EndNode 1, weight: 80.0
Starting Point 7, EndNode 2, weight: 572.0
Starting Point 7, EndNode 3, weight: 196.0
Starting Point 7, EndNode 4, weight: 77.0
Starting Point 7, EndNode 5, weight: 351.0
Starting Point 7, EndNode 6, weight: 63.0
Starting Point 7, EndNode 7, weight: 0.0
Starting Point 8, EndNode 1, weight: 134.0
Starting Point 8, EndNode 2, weight: 530.0
Starting Point 8, EndNode 3, weight: 154.0
Starting Point 8, EndNode 4, weight: 105.0
Starting Point 8, EndNode 5, weight: 309.0
Starting Point 8, EndNode 6, weight: 34.0
Starting Point 8, EndNode 7, weight: 29.0
Starting Point 8, EndNode 8, weight: 0.0
Starting Point 9, EndNode 1, weight: 259.0
Starting Point 9, EndNode 2, weight: 555.0
Starting Point 9, EndNode 3, weight: 372.0
Starting Point 9, EndNode 4, weight: 175.0
Starting Point 9, EndNode 5, weight: 338.0
Starting Point 9, EndNode 6, weight: 264.0
Starting Point 9, EndNode 7, weight: 232.0
Starting Point 9, EndNode 8, weight: 249.0
Starting Point 9, EndNode 9, weight: 0.0
Starting Point 10, EndNode 1, weight: 505.0
Starting Point 10, EndNode 2, weight: 289.0
Starting Point 10, EndNode 3, weight: 262.0
Starting Point 10, EndNode 4, weight: 476.0
Starting Point 10, EndNode 5, weight: 196.0
Starting Point 10, EndNode 6, weight: 360.0
Starting Point 10, EndNode 7, weight: 444.0
Starting Point 10, EndNode 8, weight: 402.0
Starting Point 10, EndNode 9, weight: 495.0
Starting Point 10, EndNode 10, weight: 0.0
Starting Point 11, EndNode 1, weight: 353.0
Starting Point 11, EndNode 2, weight: 282.0
Starting Point 11, EndNode 3, weight: 110.0
Starting Point 11, EndNode 4, weight: 324.0
Starting Point 11, EndNode 5, weight: 61.0
Starting Point 11, EndNode 6, weight: 208.0
Starting Point 11, EndNode 7, weight: 292.0
Starting Point 11, EndNode 8, weight: 250.0
Starting Point 11, EndNode 9, weight: 352.0
Starting Point 11, EndNode 10, weight: 154.0
Starting Point 11, EndNode 11, weight: 0.0
Starting Point 12, EndNode 1, weight: 324.0
Starting Point 12, EndNode 2, weight: 638.0
Starting Point 12, EndNode 3, weight: 437.0
Starting Point 12, EndNode 4, weight: 240.0
Starting Point 12, EndNode 5, weight: 421.0
Starting Point 12, EndNode 6, weight: 329.0
Starting Point 12, EndNode 7, weight: 297.0
Starting Point 12, EndNode 8, weight: 314.0
Starting Point 12, EndNode 9, weight: 95.0
Starting Point 12, EndNode 10, weight: 578.0
Starting Point 12, EndNode 11, weight: 435.0
Starting Point 12, EndNode 12, weight: 0.0
Starting Point 13, EndNode 1, weight: 70.0
Starting Point 13, EndNode 2, weight: 567.0
Starting Point 13, EndNode 3, weight: 191.0
Starting Point 13, EndNode 4, weight: 27.0
Starting Point 13, EndNode 5, weight: 346.0
Starting Point 13, EndNode 6, weight: 83.0
Starting Point 13, EndNode 7, weight: 47.0
Starting Point 13, EndNode 8, weight: 68.0
Starting Point 13, EndNode 9, weight: 189.0
Starting Point 13, EndNode 10, weight: 439.0
Starting Point 13, EndNode 11, weight: 287.0
Starting Point 13, EndNode 12, weight: 254.0
Starting Point 13, EndNode 13, weight: 0.0
Starting Point 14, EndNode 1, weight: 211.0
Starting Point 14, EndNode 2, weight: 466.0
Starting Point 14, EndNode 3, weight: 74.0
Starting Point 14, EndNode 4, weight: 182.0
Starting Point 14, EndNode 5, weight: 243.0
Starting Point 14, EndNode 6, weight: 105.0
Starting Point 14, EndNode 7, weight: 150.0
Starting Point 14, EndNode 8, weight: 108.0
Starting Point 14, EndNode 9, weight: 326.0
Starting Point 14, EndNode 10, weight: 336.0
Starting Point 14, EndNode 11, weight: 184.0
Starting Point 14, EndNode 12, weight: 391.0
Starting Point 14, EndNode 13, weight: 145.0
Starting Point 14, EndNode 14, weight: 0.0
Starting Point 15, EndNode 1, weight: 268.0
Starting Point 15, EndNode 2, weight: 420.0
Starting Point 15, EndNode 3, weight: 53.0
Starting Point 15, EndNode 4, weight: 239.0
Starting Point 15, EndNode 5, weight: 199.0
Starting Point 15, EndNode 6, weight: 123.0
Starting Point 15, EndNode 7, weight: 207.0
Starting Point 15, EndNode 8, weight: 165.0
Starting Point 15, EndNode 9, weight: 383.0
Starting Point 15, EndNode 10, weight: 240.0
Starting Point 15, EndNode 11, weight: 140.0
Starting Point 15, EndNode 12, weight: 448.0
Starting Point 15, EndNode 13, weight: 202.0
Starting Point 15, EndNode 14, weight: 57.0
Starting Point 15, EndNode 15, weight: 0.0
Starting Point 16, EndNode 1, weight: 246.0
Starting Point 16, EndNode 2, weight: 745.0
Starting Point 16, EndNode 3, weight: 472.0
Starting Point 16, EndNode 4, weight: 237.0
Starting Point 16, EndNode 5, weight: 528.0
Starting Point 16, EndNode 6, weight: 364.0
Starting Point 16, EndNode 7, weight: 332.0
Starting Point 16, EndNode 8, weight: 349.0
Starting Point 16, EndNode 9, weight: 202.0
Starting Point 16, EndNode 10, weight: 685.0
Starting Point 16, EndNode 11, weight: 542.0
Starting Point 16, EndNode 12, weight: 157.0
Starting Point 16, EndNode 13, weight: 289.0
Starting Point 16, EndNode 14, weight: 426.0
Starting Point 16, EndNode 15, weight: 483.0
Starting Point 16, EndNode 16, weight: 0.0
Starting Point 17, EndNode 1, weight: 121.0
Starting Point 17, EndNode 2, weight: 518.0
Starting Point 17, EndNode 3, weight: 142.0
Starting Point 17, EndNode 4, weight: 84.0
Starting Point 17, EndNode 5, weight: 297.0
Starting Point 17, EndNode 6, weight: 35.0
Starting Point 17, EndNode 7, weight: 29.0
Starting Point 17, EndNode 8, weight: 36.0
Starting Point 17, EndNode 9, weight: 236.0
Starting Point 17, EndNode 10, weight: 390.0
Starting Point 17, EndNode 11, weight: 238.0
Starting Point 17, EndNode 12, weight: 301.0
Starting Point 17, EndNode 13, weight: 55.0
Starting Point 17, EndNode 14, weight: 96.0
Starting Point 17, EndNode 15, weight: 153.0
Starting Point 17, EndNode 16, weight: 336.0
Starting Point 17, EndNode 17, weight: 0.0
```
"

# ╔═╡ 043c52fb-0a58-4bdf-aa9c-32d5216c3a08


# ╔═╡ dc6afbc2-3a75-4adb-85a3-9520c9ae4bfa
# Questions 

# ╔═╡ aeeed655-c80c-486a-9dba-862cfbd41cd3
Summary of what we did and what we learn

# ╔═╡ Cell order:
# ╠═bc370dd0-1be8-11ec-07f6-e7ed296b0324
# ╠═4dc27f4d-7c9c-4d93-b3c3-eb7cd5d73413
# ╠═f05adbc6-d170-49ad-a079-5748d314db4c
# ╠═65a51afa-6063-43b6-bca4-4a025cfc722e
# ╠═3687542f-1a0e-4082-9bdd-1c2f8c0abcaf
# ╠═3b377075-470a-498e-88e3-728879906f78
# ╠═b1130557-6671-44bb-9354-34a0acd46ca1
# ╠═043c52fb-0a58-4bdf-aa9c-32d5216c3a08
# ╠═dc6afbc2-3a75-4adb-85a3-9520c9ae4bfa
# ╠═aeeed655-c80c-486a-9dba-862cfbd41cd3