using Plots

"""Analyse un fichier .tsp et renvoie un dictionnaire avec les données de l'entête.
EN: Parses a .tsp file and returns a dictionary with the header data.
"""
function read_header(filename::String)

  file = open(filename, "r")
  header = Dict{String}{String}()
  sections = ["NAME", "TYPE", "COMMENT", "DIMENSION", "EDGE_WEIGHT_TYPE", "EDGE_WEIGHT_FORMAT",
  "EDGE_DATA_FORMAT", "NODE_COORD_TYPE", "DISPLAY_DATA_TYPE"]

  # Initialize header
  for section in sections
    header[section] = "None"
  end

  for line in eachline(file)
    line = strip(line)
    data = split(line, ":")
    if length(data) >= 2
      firstword = strip(data[1])
      if firstword in sections
        header[firstword] = strip(data[2])
      end
    end
  end
  close(file)
  return header
end

"""Analyse un fichier .tsp et renvoie un dictionnaire des noeuds sous la forme {id => [x,y]}.
Si les coordonnées ne sont pas données, un dictionnaire vide est renvoyé.
Le nombre de noeuds est dans header["DIMENSION"].
EN:
Parses a .tsp file and returns a dictionary of nodes in the form {id => [x,y]}.
If coordinates are not given, an empty dictionary is returned.
The number of nodes is in header["DIMENSION"].

"""
function read_nodes(header::Dict{String}{String}, filename::String)

  nodes = Dict{Int}{Vector{Float64}}()
  node_coord_type = header["NODE_COORD_TYPE"]
  display_data_type = header["DISPLAY_DATA_TYPE"]


  if !(node_coord_type in ["TWOD_COORDS", "THREED_COORDS"]) && !(display_data_type in ["COORDS_DISPLAY", "TWOD_DISPLAY"])
    return nodes
  end

  file = open(filename, "r")
  dim = parse(Int, header["DIMENSION"])
  k = 0
  display_data_section = false
  node_coord_section = false
  flag = false

  for line in eachline(file)
    if !flag
      line = strip(line)
      if line == "DISPLAY_DATA_SECTION"
        display_data_section = true
      elseif line == "NODE_COORD_SECTION"
        node_coord_section = true
      end

      if (display_data_section || node_coord_section) && !(line in ["DISPLAY_DATA_SECTION", "NODE_COORD_SECTION"])
        data = split(line)
        nodes[parse(Int, data[1])] = map(x -> parse(Float64, x), data[2:end])
        k = k + 1
      end

      if k >= dim
        flag = true
      end
    end
  end
  close(file)
  return nodes
end

"""Fonction auxiliaire de read_edges, qui détermine le nombre de noeud à lire
en fonction de la structure du graphe.
EN:
Auxiliary function of read_edges, which determines the number of nodes to read according to the structure of the graph.

"""
function n_nodes_to_read(format::String, n::Int, dim::Int)
  if format == "FULL_MATRIX"
    return dim
  elseif format in ["LOWER_DIAG_ROW", "UPPER_DIAG_COL"]
    return n+1
  elseif format in ["LOWER_DIAG_COL", "UPPER_DIAG_ROW"]
    return dim-n
  elseif format in ["LOWER_ROW", "UPPER_COL"]
    return n
  elseif format in ["LOWER_COL", "UPPER_ROW"]
    return dim-n-1
  else
    error("Unknown format - function n_nodes_to_read")
  end
end

"""Analyse un fichier .tsp et renvoie l'ensemble des arêtes sous la forme d'un tableau.
EN: Parses a .tsp file and returns the set of edges as an array."""
function read_edges(header::Dict{String}{String}, filename::String)

  edges = []
  edges_weight = Dict{Vector{Float64}}{Float64}() # we save them as (1,2) weigth 34.4 
  edge_weight_format = header["EDGE_WEIGHT_FORMAT"]
  known_edge_weight_formats = ["FULL_MATRIX", "UPPER_ROW", "LOWER_ROW",
  "UPPER_DIAG_ROW", "LOWER_DIAG_ROW", "UPPER_COL", "LOWER_COL",
  "UPPER_DIAG_COL", "LOWER_DIAG_COL"]

  if !(edge_weight_format in known_edge_weight_formats)
    @warn "unknown edge weight format" edge_weight_format
    return edges
  end

  file = open(filename, "r")
  dim = parse(Int, header["DIMENSION"])
  edge_weight_section = false
  k = 0
  n_edges = 0
  i = 0
  n_to_read = n_nodes_to_read(edge_weight_format, k, dim)
  flag = false

  for line in eachline(file)
    line = strip(line)
    if !flag
      if occursin(r"^EDGE_WEIGHT_SECTION", line)
        edge_weight_section = true
        continue
      end

      if edge_weight_section
        data = split(line)
        n_data = length(data)
        start = 0
        
        while n_data > 0
          n_on_this_line = min(n_to_read, n_data)
          for j = start : start + n_on_this_line - 1
            weight = parse(Float64, data[j+1])
            n_edges = n_edges + 1
            if edge_weight_format in ["UPPER_ROW", "LOWER_COL"]
              edge = (k+1, i+k+2, weight)
            elseif edge_weight_format in ["UPPER_DIAG_ROW", "LOWER_DIAG_COL"]
              edge = (k+1, i+k+1, weight)
            elseif edge_weight_format in ["UPPER_COL", "LOWER_ROW"]
              edge = (i+k+2, k+1, weight)
            elseif edge_weight_format in ["UPPER_DIAG_COL", "LOWER_DIAG_ROW"]
              edge = (i+1, k+1, weight)
            elseif edge_weight_format == "FULL_MATRIX"
              edge = (k+1, i+1, weight)
            else
              warn("Unknown format - function read_edges")
            end

            # Way one 
            ## weight = parse(Float64, data[j+1]) # turn string to Int64 then float64   # TODO change this to be a array of weights
            ## edges_weight[edge] = map(x -> parse(Float64, x)  data[j+1]) #change the name later  or data[j-start+1]
            # way two
            # We will include the weight in the data
            push!(edges, edge)
            i += 1
          end 

          n_to_read -= n_on_this_line
          n_data -= n_on_this_line

          if n_to_read <= 0
            start += n_on_this_line
            k += 1
            i = 0
            n_to_read = n_nodes_to_read(edge_weight_format, k, dim)
          end

          if k >= dim
            n_data = 0
            flag = true
          end
        end
      end
    end
  end
  close(file)
  return edges#, edges_weight
end

"""Renvoie les noeuds et les arêtes du graphe.

En: Returns the nodes and edges of the graph."""

function read_stsp(filename::String)
  Base.print("Reading of header : ")
  header = read_header(filename)
  println("✓")
  dim = parse(Int, header["DIMENSION"])
  edge_weight_format = header["EDGE_WEIGHT_FORMAT"]

  Base.print("Reading of nodes : ")
  graph_nodes = read_nodes(header, filename)
  println("✓")

  Base.print("Reading of edges : ")
  edges_brut = read_edges(header, filename)
  graph_edges = []
  for k = 1 : dim
    edge_list =  Tuple{Int, Float64}[]#  Int[] # change this to be a tuple
    push!(graph_edges, edge_list)
  end

  # Here it adds edges to each nodes 
  for edge in edges_brut
    if edge_weight_format in ["UPPER_ROW", "LOWER_COL", "UPPER_DIAG_ROW", "LOWER_DIAG_COL"]
      push!(graph_edges[edge[1]], (edge[2],edge[3])) # I am adding weight to the edges
    else
      push!(graph_edges[edge[2]], (edge[1], edge[3]))
    end
  end

  for k = 1 : dim
    graph_edges[k] = sort(graph_edges[k])
  end
  println("✓")
  return graph_nodes, graph_edges
end

"""Affiche un graphe étant données un ensemble de noeuds et d'arêtes.
EN: Displays a graph given a set of nodes and edges.
Exemple :

    graph_nodes, graph_edges = read_stsp("bayg29.tsp")
    plot_graph(graph_nodes, graph_edges)
    savefig("bayg29.pdf")
"""

function plot_graph(nodes, edges)
  fig = plot(legend=false)

  # edge positions
  for k = 1 : length(edges)
    for j in edges[k]
      plot!([nodes[k][1], nodes[j][1]], [nodes[k][2], nodes[j][2]],
          linewidth=1.5, alpha=0.75, color=:lightgray)
    end
  end

  # node positions
  xys = values(nodes)
  x = [xy[1] for xy in xys]
  y = [xy[2] for xy in xys]
  scatter!(x, y)

  fig
end
# """Fonction de commodité qui lit un fichier stsp et trace le graphe EN: Convenience function that reads an stsp file and plots the graph"""
function plot_graph(filename::String)
  graph_nodes, graph_edges = read_stsp(filename)
  plot_graph(graph_nodes, graph_edges)
end



