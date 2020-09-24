import Base.show
include(joinpath(@__DIR__, "read_stsp.jl"))


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
  edges::Vector{Edge{P}}
end

"""Ajoute un noeud au graphe."""
function add_node!(graph::Graph{T,P}, node::Node{T}) where {T,P}
  push!(graph.nodes, node)
  graph
end

"""Ajoute une arêtes au graphe."""
function add_edge!(graph::Graph{T,P}, edge::Edge{P}) where {T,P}

  #If one of the vertex is not in the graph we do not add the edge
  if findfirst(x->x==edge.nodes[1],[nd.name for nd in graph.nodes])==nothing || findfirst(x->x==edge.nodes[2],[nd.name for nd in graph.nodes])==nothing 
    println("The vertex of the edge are not in the graph")
    return 0
  end
#If the edge is already present we do not add it again
  v1=[ed.nodes[1] for ed in graph.edges] #vetor of first vertex
  v2=[ed.nodes[2] for ed in graph.edges]#vector of second vertex
  #We check the second vertex of all edge that have first vertex equal to the first vertex of the new edge and
  #we check the second vertex of all edge that have first vertex equal to the second vertex of the new edge
  if findfirst(x->x==edge.nodes[2],v2[findall(x->x==edge.nodes[1],v1)])!=nothing || findfirst(x->x==edge.nodes[1],v2[findall(x->x==edge.nodes[2],v1)])!=nothing
    println("This edge is already in the graph")
    return 0
  end
 # If the new edge pass al the check before we can add it to the graph
  push!(graph.edges, edge)

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

function build_graph(filename::String)
  nodes, edges = read_stsp(filename)
  header = read_header(filename)

  return Graph(header["NAME"], [Node("$(node[1])", node[2]) for node in nodes], [Edge(("$(edge[1][1])", "$(edge[1][2])"), edge[2]) for edge in edges])
end