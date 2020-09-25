import Base.showerror

struct NodeError <: Exception
    var::String
end
Base.showerror(io::IO, e::NodeError) = println(io, "Unknown node:", e.var, "!")

struct EdgeError <: Exception
    var::String
end
Base.showerror(io::IO, e::EdgeError) = println(io, "Edge error:", e.var, "!")
