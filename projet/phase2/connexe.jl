import Base.show

"""Type abstrait dont d'autres types d'arbres connexes dériveront."""
abstract type AbstractConnex{T} end

"""Type représentant un arbre connexe avec des éléments de type T."""
mutable struct Connex{T} <: AbstractConnex{T}
    name::String
    nodes::Vector{Node{T}}
    edges::Vector{Edge}
end


"""Ajoute un noeud au sous-graphe."""
function add_node!(connex::Connex{T}, node::Node{T}) where T
 push!(connex.nodes, node)
    connex
end


"""Ajoute une arete de poids non nul au sous-graphe. """
function add_edge!(connex::Connex, edge:: Edge)  
  for k = 1 : length(edges)  
   if edges[][][k] != 0                              # Les arêtes de poids nuls ne seront pas prises en compte
    push!(connex.edges, edge)
    connex
    end 
  end
end
  
  
# on présume que tous les graphes dérivant d'AbstractGraph
# posséderont des champs `name` et `nodes`.
  
"""Renvoie le nom du sous-graphe."""
name(connex::AbstractConnex) = connex.name
  
"""Renvoie la liste des noeuds du sous-graphe."""
function nodes(connex::AbstractConnex)
    connex.nodes
end
""" Renvoie la liste des aretes du sous-graphe. """
edges(connex::AbstractConnex) = connex.edges
  
"""Renvoie le nombre de noeuds du sous-graphe."""
nb_nodes(connex::AbstractConnex) = length(connex.nodes)
  
""" Renvoie le nombre d'arêtes du sous-graphe. """
nb_edges(connex::AbstractConnex) = length(connex.edges)
  
"""Affiche un graphe"""
function show(connex::Connex)
    println("Sub-Graph ", name(connex), " has ", nb_nodes(connex), " nodes.")
    for node in nodes(connex)
      show(node)
    end
  
  
    println("Sub-Graph ", name(connex), " has ", nb_edges(connex), " edges.")
    for edge in edges(connex)
      show(edge)
    end
end