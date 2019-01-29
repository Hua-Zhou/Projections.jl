export Simplex

struct Simplex{T <: Real} <: ConvexSet
    r::T
end
Simplex() = Simplex(1.0)

function project!(s::Simplex{<:Real}, v::Vector{T}, y::Vector{T}) where {T <: Real}
    n = length(y)
    copyto!(v, y)
    sort!(v, rev = true)
    ss, λ = zero(T), zero(T)
    for i in 1:n
        ss += v[i]
        λ = (ss - s.r) / i
        if i < n && λ < v[i] && λ ≥ v[i + 1]
            break
        end
    end
    v .= max.(y .- λ, 0)
end

function project(s::Simplex{<:Real}, y::Vector{<:Real})
    project!(s, similar(y), y)
end
