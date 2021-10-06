#import Base.length, Base.push!, Base.popfirst!
import Base.show






function find_connex!(lis_connex, node_to_find)
    for i = 1 :  length(lis_connex)
        for node in nodes(lis_connex[i])
            if node.name == node_to_find.name
                connex = lis_connex[i]
                deleteat!(lis_connex, i)
                return connex
            end
        end
    end
end

function isinConnex(connex:: Connex, node_to_find:: Node)
    for node in nodes(connex)
        if node.name == node_to_find.name
            return true
        
        end
    end
    return false
end







"""Applique l'algorithme de Kruskal sur un graphe dont le nom est donné en argument."""
function kruskal(filename::String)
    lis_nodes, lis_edges = create_sub_graph(filename)
    
    lis_connex= []
    for node in lis_nodes 
        lis_connex = append!(lis_connex, [Connex([node])])
    end
    lis_aretes = Edge[]
    while length(lis_connex) >= 2
        arete = popfirst!(lis_edges)
        connex1 = find_connex!(lis_connex,Node(arete[1], []))
        if isinConnex(connex1, Node(arete[2], []))
            lis_connex = append!(lis_connex, [connex1])
        else
            connex2 = find_connex!(lis_connex,Node(arete[2], []))
            lis_aretes = append!(lis_aretes, [Edge(arete[1], arete[2], arete[3])])
            connex_fusionne = merge(connex1, connex2)
            lis_connex = append!(lis_connex, [connex_fusionne])
            
        end
    end
    Graph("Arbre recouvrement minimal",lis_nodes,lis_aretes)
    
end