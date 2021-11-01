include("node.jl")

mutable struct BinaryTree{T} <: AbstractNode{T}
    name::String
    data::T
    left::Union{BinaryTree{T}, Nothing}
    right::Union{BinaryTree{T}, Nothing}
    parent::Union{BinaryTree{T}, Nothing}
end

function BinaryTree(data::T;
                    name::String="",
                    left::Union{BinaryTree{T}, Nothing}=nothing,
                    right::Union{BinaryTree{T}, Nothing}=nothing,
                    parent::Union{BinaryTree{T}, Nothing}=nothing) where T
    BinaryTree(name, data, left, right, parent)
end

left(bt::BinaryTree) = bt.left
right(bt::BinaryTree) = bt.right
parent(bt::BinaryTree) = bt.parent

function set_left!(bt::BinaryTree{T}, l::BinaryTree{T}) where T
    bt.left = l
    bt
end

function set_right!(bt::BinaryTree{T}, r::BinaryTree{T}) where T
    bt.right = r
    bt
end

function set_parent!(bt::BinaryTree{T}, p::BinaryTree{T}) where T
    bt.parent = p
    bt
end

show(bt::BinaryTree) = show(data(bt))  # pour simplifier

# function show(bt::BinaryTree)
#     bname = name(bt)
#     s = "BinaryTree $(bname)"
#     if parent(bt) != nothing
#         pname = name(parent(bt))
#         s *= " with parent $(pname)"
#     end
#     if left(bt) != nothing
#         lname = name(left(bt))
#         s *= " with left child $(lname)"
#     end
#     if right(bt) != nothing
#         rname = name(right(bt))
#         s *= " with right child $(rname)"
#     end
#     println(s)
# end
