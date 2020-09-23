import Base.show

"""Type abstrait dont d'autres types de graphes dériveront."""
abstract type AbstractGraph{T,P} end

"""Type representant un graphe comme un ensemble de noeuds.

Exemple :

    node1 = Node("Joe", 3.14)
    node2 = Node("Steve", exp(1))
    node3 = Node("Jill", 4.12)
    G = Graph("Ick", [node1, node2, node3])

Attention, tous les noeuds doivent avoir des données de même type.
"""
mutable struct Graph{T, P} <: AbstractGraph{T,P}
  name::String
  nodes::Vector{Node{T}}
  edges::Vector{Edge{T,P}}
end

"""Ajoute un noeud au graphe."""
function add_node!(graph::Graph{T,P}, node::Node{T}) where {T,P}
  push!(graph.nodes, node)
  graph
end

"""Ajoute une arêtes au graphe."""
function add_edge!(graph::Graph{T,P}, edge::Edge{T,P}) where {T,P}
  # First we do 2 controls: the vertex of the edge are nodes of the graph and the edge is not already in the graph
  check=false #control variable that will be false untill we found both the verex of the edge among the nodes of the graph
  k=0 #variable that count how many vertex of the edge we found among the nodes of the graph
  cont=1 #iteration counter
  dim=length(graph.nodes)
  while cont<=dim && !check
    if graph.nodes[cont]==edge.nodes[1]
      k=k+1
    end
    if graph.nodes[cont]==edge.nodes[2]
      k=k+1
    end
    if k>=2 #if we have found both the vertex we can exit the loop
      check=true
    end
    cont=cont+1
  end
  if !check #If we are out of the loop withou having found both vertex there is a problem
    println("The vertex of the edge are not in the graph")
  end
  check2=false #control variable that will be false unless we found the current edge among the edges that are already in the graph
  dim2=length(graph.edges)
  cont=1
  while cont<=dim2 && !check2
    currEdg=graph.edges[cont]
    #since we are using tuples we have to do 2 controls to check if the vertex of 2 edges are the same
    if (currEdg.nodes[1]==edge.nodes[1] && currEdg.nodes[2]==edge.nodes[2]) || (currEdg.nodes[2]==edge.nodes[1] && currEdg.nodes[1]==edge.nodes[2])
      println("This edge is already in the graph")
      check2=true
    end
    cont=cont+1
  end
  if check && !check2 #If the vertex are not node of the graph or the edge is already in the grap we should not add the new edge
  push!(graph.edges, edge)
  end
end

# on présume que tous les graphes dérivant d'AbstractGraph
# posséderont des champs `name` et `nodes`.

"""Renvoie le nom du graphe."""
name(graph::AbstractGraph) = graph.name

"""Renvoie la liste des noeuds du graphe."""
nodes(graph::AbstractGraph) = graph.nodes

"""Renvoie la liste des arêtes du graphe."""
edges(graph::AbstractGraph) = graph.edges

"""Renvoie le nombre de noeuds du graphe."""
nb_nodes(graph::AbstractGraph) = length(graph.nodes)

"""Affiche un graphe"""
function show(graph::Graph)
  println("Graph ", name(graph), " has ", nb_nodes(graph), " nodes.")
  for node in nodes(graph)
    show(node)
  end
  for edge in edges(graph)
    show(edge)
  end
end
