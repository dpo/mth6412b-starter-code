import Base.show
import Base.sort!

"""
Exemple :

  node1 = Node("Montreal", 24.12)
  node2 = Node("Quebec", 4.12)
  composante = ConnexComp([node1, node2])

"""
mutable struct ConnexComp{T}
  nodes::Vector{Node{T}}
  name::String
end
ConnexComp(nodes::Vector{Node{T}}; name::String="") where T = ConnexComp(nodes,name)

"""Renvoie le nom de la composante connexe."""
name(comp::ConnexComp) = comp.name
"""Renvoie le vecteur des sommets de la composante connexe."""
nodes(comp::ConnexComp) = comp.nodes

"""
Affichage convivial d'une composante connexe.
"""
function show(comp::ConnexComp{T}) where T
  for node in nodes(comp)
    show(node)
  end
end

"""
Trie les sommets d'une composante connexe en ordre décroissant des rangs.
"""
function sort!(comp::ConnexComp{T}) where T
    sort!(nodes(comp))
    return comp
end