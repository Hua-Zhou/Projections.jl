export Box

"""
Box set.
"""
struct Box{T <: Real} <: ConvexSet
    a::Vector{T}
    b::Vector{T}
    function Box(a::Vector{T}, b::Vector{T}) where T <: Real
        length(a) == length(b) || throw(ArgumentError("lengths of lower/upper bounds do not match"))
        new{T}(a, b)
    end
end

function project!(s::Box{T}, v::Vector{T}, y::Vector{T}) where T <: Real
    v .= clamp.(y, s.a, s.b)
end

function project(s::Box{T}, y::Vector{T}) where T <: Real
    project!(s, similar(y), y)
end




