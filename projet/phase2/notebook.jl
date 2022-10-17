### A Pluto.jl notebook ###
# v0.19.11

using Markdown
using InteractiveUtils

# ╔═╡ 0adf514a-4e1a-11ed-3a00-856fd5050585
md"""## Projet du voyageur de commerce : Phase 1"""

# ╔═╡ 99956331-b417-48ae-833b-cb98784b4f27
md"""Abdou Samad Dicko(2037205), Clélia Merel(2163025), Myriam Lévy(2225114)"""

# ╔═╡ 96a61622-9d2e-4065-964a-251e342ce7ec
md"""### Création de la strcture *Comp*
Cette structure permet de représenter les composantes connexes d'un graphe. Comme suggéré en lab, elle contient deux attributs : une racine de typer *Node* et une liste d'enfants sous forme de tuples de type (*Node*, *Node*) où le premier élément est un nœud de la composante connexe et le deuxième est son parent. La racine est dans cette liste et elle est son propre parent. Pour l'instant, on ne se sert pas de cette association parent-enfant dans nos fonctions mais elle permet par exemple de remonter jusqu'à la racine à partir de n'importe quel nœud enfant. 

```julia
abstract type AbstractComp{T} end

mutable struct Comp{T} <: AbstractComp{T}
    root::Node{T}
    children::Vector{Tuple{Node{T}, Node{T}}} 
end
```

Dans cette strcture on implémente les méthodes *root* et *children* qui renvoient respectivement la racine et la liste des nœuds enfant-parent de la composante connexe : 

```julia
root(comp::AbstractComp) = comp.root

children(comp::AbstractComp) = comp.children
```

On crée la fonction *merge!* qui permet de fusionner deux composantes connexes en modifiant la première et en gardant sa racine comme racine de la nouvelle composante connexe : 

```julia
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
```

Enfin, on crée la fonction *in_comp* qui vérifie si un nœud se trouve ou non dans une composante connexe et renvoie un booléen : 

```julia
function in_comp(comp::Comp{T}, node::Node{T}) where T
    for i = 1 : length(children(comp))
        if children(comp)[i][1] == node
            return true
        end
    end
    return false
end
```

"""

# ╔═╡ 77ddf67c-0c4a-49a0-8ec8-d428ebaef315
md"""### Implémentation de l'algorithme de Kruskal

"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.0"
manifest_format = "2.0"
project_hash = "da39a3ee5e6b4b0d3255bfef95601890afd80709"

[deps]
"""

# ╔═╡ Cell order:
# ╟─0adf514a-4e1a-11ed-3a00-856fd5050585
# ╟─99956331-b417-48ae-833b-cb98784b4f27
# ╠═96a61622-9d2e-4065-964a-251e342ce7ec
# ╠═77ddf67c-0c4a-49a0-8ec8-d428ebaef315
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
