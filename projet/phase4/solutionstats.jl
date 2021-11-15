import Base.show, Base.println, Base.print

abstract type AbstractSolution{T, I} end

"""
Type contenant les informations d'une solution trouvée par l'algortihme RSL.
Contient les attributs:

- `cout::Float64`: coût minimal trouvé par l'algorithme,
- `elapsed_time::Float64`: temps de résolution,
- `elapsed_time_cost::Float64`: temps de résolution incluant le calcul du coût en plus de la tournée,
- `graphe::Graph{T, I}`: graphe en sortie d'algorithme,
"""
mutable struct RSLsolution{T, I} <: AbstractSolution{T, I}
    cout::Float64
    elapsed_time::Float64
    elapsed_time_cost::Float64
    graphe::Graph{T, I}
end

"""
Type contenant les informations d'une solution trouvée par l'algortihme de Held et Karp.
Contient les attributs:

- `cout::Float64`: coût minimal trouvé par l'algorithme,
- `status::String`: status à la fin de l'algorithme,
- `arbre::Vector{Union{Nothing, Edge{T, I}}}`: 1-arbre en sortie d'algorithme (tour si status optimal),
- `σw::Float64`: écart-type`de `w` pour les `wmemorysize` dernière itérations,
- `nbiter::Int`: nombre d'itérations,
- `elapsed_time::Float64`: temps de résolution,
- `wmemorysize::Int`: paramètre pour la taille du vecteur d'écart-types des dernières itérations de la fonction,
- `graphe::Graph{T, I}`: graphe en sortie d'algorithme,
"""
mutable struct Hksolution{T, I} <: AbstractSolution{T, I}
    cout::Float64
    status::String
    arbre::Vector{Union{Nothing, Edge{T, I}}}
    σw::Float64
    nbiter::Int
    elapsed_time::Float64
    wmemorysize::Int
    graphe::Graph{T, I}
end

cout(solution::AbstractSolution) = solution.cout
elapsed_time(solution::AbstractSolution) = solution.elapsed_time
graphe(solution::AbstractSolution) = solution.graphe

elapsed_time_cost(solution::RSLsolution) = solution.elapsed_time_cost

status(solution::Hksolution) = solution.status
arbre(solution::Hksolution) = solution.arbre
σw(solution::Hksolution) = solution.σw
nbiter(solution::Hksolution) = solution.nbiter
wmemorysize(solution::Hksolution) = solution.wmemorysize

function print(io::IO, solution::RSLsolution{T, I}) where {T, I}
    println("Cout = ", cout(solution))
    println("Temps sans cout (s) = ", elapsed_time(solution))
    println("Temps total (s) = ", elapsed_time_cost(solution))
end

function show(io::IO, solution::RSLsolution{T, I}) where {T, I}
    show(io, "RSLsolution")
end

function print(io::IO, solution::Hksolution{T, I}) where {T, I}
    println("Cout = ", cout(solution))
    println("Status = ", status(solution))
    println("σ des ", wmemorysize(solution), " dernières itérations = ", σw(solution))
    println("Nombre d'itérations = ", nbiter(solution))
    println("Temps total (s) = ", elapsed_time(solution))
end

function show(io::IO, solution::Hksolution{T, I}) where {T, I}
    show(io, "Hksolution : $(status(solution))")
end

print(solution::AbstractSolution) = print(Base.stdout, solution)
println(io::IO, solution::AbstractSolution) = print(io, solution)
println(solution::AbstractSolution) = print(Base.stdout, solution)

"""Affiche une tournée étant donné un objet de type `AbstractSolution`."""
function plot_tour(solution::Hksolution)
  sommets = nodes(graphe(solution))
  edges = arbre(solution)
  fig = plot(legend=false)

  # edge positions
  for edge in edges
    plot!([coordinates(data(edge)[1])[1], coordinates(data(edge)[2])[1]],
          [coordinates(data(edge)[1])[2], coordinates(data(edge)[2])[2]],
          linewidth=1.5, alpha=0.75, color=:lightgray)
  end

  # node positions
  xys = [coordinates(node) for node in sommets]
  x = [xy[1] for xy in xys]
  y = [xy[2] for xy in xys]
  scatter!(x, y)

  title!(string("1-arbre dans ", name(graphe(solution))))
  fig
end

function plot_tour(solution::RSLsolution)
  sommets = nodes(graphe(solution))
  fig = plot(legend=false)

  # edge positions
  for i in 1:(length(sommets)-1)
    plot!([coordinates(sommets[i])[1], coordinates(sommets[i+1])[1]],
          [coordinates(sommets[i])[2], coordinates(sommets[i+1])[2]],
          linewidth=1.5, alpha=0.75, color=:lightgray)
  end
  plot!([coordinates(sommets[end])[1], coordinates(sommets[1])[1]],
        [coordinates(sommets[end])[2], coordinates(sommets[1])[2]],
        linewidth=1.5, alpha=0.75, color=:lightgray)

  # node positions
  xys = [coordinates(node) for node in sommets]
  x = [xy[1] for xy in xys]
  y = [xy[2] for xy in xys]
  scatter!(x, y)

  title!(string("tournée dans ", name(graphe(solution))))
  fig
end