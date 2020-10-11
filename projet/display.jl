macro display(filename)
  include(filename)
  open(filename, "r") do file
    for line in readlines(file)
      println(line)
    end
  end
end
