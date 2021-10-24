import Base.length, Base.push!, Base.popfirst!
import Base.show
import Base.maximum
import Base.minimum
import Base.isless, Base.==


"""Type abstrait dont d'autres types de files dériveront."""
abstract type AbstractQueue{T} end

"""Type représentant une file de sommets de priorité."""
mutable struct NodeQueue{T} <: AbstractQueue{T}
    items::Vector{Node{T}}
end
NodeQueue{T}() where T = NodeQueue(Node{T}[])

"""Ajoute un item à la fin d'une file."""
function push!(q::AbstractQueue{T}, item::T) where T
    push!(q.items, item)
    q
end

"""Retire et renvoie l'objet du début de la file."""
popfirst!(q::AbstractQueue) = popfirst!(q.items)

"""Indique si la file est vide."""
is_empty(q::AbstractQueue) = length(q.items) == 0

"""Donne le nombre d'éléments sur la file."""
length(q::AbstractQueue) = length(q.items)

"""Affiche une file."""
show(q::AbstractQueue) = show(q.items)

"""Donne le plus grand item d'une file."""
maximum(q::AbstractQueue) = maximum(q.items)

"""Donne le plus petit item d'une file."""
minimum(q::AbstractQueue) = minimum(q.items)

"""Retire et renvoie l'élément ayant la plus basse priorité."""
function popfirst!(q::NodeQueue)
    lowest = q.items[1]
    for item in q.items[2:end]
        if min_weight(item) < min_weight(lowest)
            lowest = item
        end
    end
    idx = findfirst(x -> min_weight(x) == min_weight(lowest), q.items)
    deleteat!(q.items, idx)
    lowest
end

"""Affiche une file de priorité de sommets de façon lisible"""
function show(q::NodeQueue)
    show([item for item in q.items])
end