export Ball

struct Ball{T <: Real} <: ConvexSet
    center::Vector{T}
    radius::T
end

"""
    Ball()
    Ball(c, r)

A ball with center `c` and radius `r`.
"""
function Box(c::Vector{T}, r::T) where T <: Real
    r ≥ 0 || throw(ArgumentError("radius should be positive"))
    Ball(c, r)
end

"""
    Ball(n)
    Ball(n, r)

A `n` dimensional ball with center `zeros(n)` and radius `r`.
"""
Ball(n::Integer, r::Real=1.0) = Ball(zeros(typeof(r), n), r)

function project!(s::Ball{T}, v::Vector{T}, y::Vector{T}) where T <: Real
    v .= y .- s.center
    distance = sqrt(sum(abs2, v))
    if distance > s.radius
        v .= s.center .+ (s.radius / distance) .* v
    else
        copyto!(v, y)
    end
    v
end

function project(s::Ball{T}, y::Vector{T}) where T <: Real
    project!(s, similar(y), y)
end
