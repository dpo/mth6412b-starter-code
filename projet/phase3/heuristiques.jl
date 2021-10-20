include("node.jl")
include("edge.jl")
include("graph.jl")
include("connexe.jl")
include("read_stsp.jl")


function heuristique1(dico_rang::Dict, dico_parents::Dict,  connex1::Connex, connex2::Connex)
    max_rang1= 0
    sommet_max1 = connex1[1]
    max_rang2 = 0
    sommet_max2 = connex2[1]

    for sommet in connex1
        if dico_rang[sommet.name]> max_rang1
            max_rang1 = dico_rang[sommet.name]
            sommet_max1 = sommet
        end
    end

    for sommet in connex2
        if dico_rang[sommet.name]> max_rang2
            max_rang2 = dico_rang[sommet.name]
            sommet_max2 = sommet
        end
    end
    
    if max_rang1 > max_rang2
        dico_parents[sommet_max2] = sommet_max1
    else 
        if max_rang2 > max_rang1
            dico_parents[sommet_max1] = sommet_max2
        else
            dico_parents[sommet_max2] = sommet_max1
            dico_rang[sommet_max1] += 1
        end
    end
   
    merge!(connex1,connex2)
end

function heuristique2!(noeud::Node,dico_parents::Dict,dico_rangs::Dict)
    lis_parents = [noeud]
    parent = dico_parents[noeud.name]
    while parent.name != dico_parents[parent.name].name
        push!(lis_parents, parent)
        parent = dico_parents[parent.name]
    end

    for sommet in lis_parents
        dico_parents[sommet.name] = parent
        dico_rangs[sommet.name] = 1 
    end

    dico_parents,dico_rangs

end

