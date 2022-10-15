using Test


abstract type AbstractComp{T} end

mutable struct Comp{T} <: AbstractComp{T}
    root::Node{T}
    children::Vector{Tuple{Node{T}, Node{T}}} #chaque enfant est un tuple de la forme (enfant, parent)
end

root(comp::AbstractComp) = comp.root

children(comp::AbstractComp) = comp.children

function merge!(comp1::Comp{T}, comp2::Comp{T}) where T
    r1 = root(comp1)
    r2 = root(comp2)
    l1 = length(comp1.children)
    l2 = length(comp2.children)
    for i = 1 : length(comp2.children)
        r = comp2.children[i]
        if r[1] != r2 
            push!(comp1.children, r)
    
        end
    end
    push!(comp1.children, (r2, r1))
    @test length(comp1.children) == l1 + l2 #Vérifie que la fusion des deux composantes connexe contient bien le bon nombre de noeuds
    return comp1
end

function in_comp(comp::Comp{T}, node::Node{T}) where T
    for i = 1 : length(children(comp))
        if children(comp)[i][1] == node
            return true
        end
    end
    return false
end
