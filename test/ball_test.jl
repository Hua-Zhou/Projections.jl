module BallTest

using Projections, Test

@testset "ball" begin
y = [-2.5, -1.5, -0.5, 0.0, 0.5, 1.5, 2.5]
n = length(y)
@show sqrt(sum(abs2, y))
@test isapprox(project(Ball(n), y), [-0.597614, -0.358569, -0.119523, 0.0, 
    0.119523, 0.358569, 0.597614], rtol=1e-4)
@test all(project(Ball(n, 5.), y) .== y)
end

end
