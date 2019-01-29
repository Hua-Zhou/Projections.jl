module SimplexTest

using Projections, Test

@testset "simplex" begin
y = [1., 1., 1.]
@test isapprox(project(Simplex(), y), fill(1//3, 3), rtol=1e-6)
y = [1., 0., 0.]
@test isapprox(project(Simplex(), y), y, rtol=1e-6)
y = [0., 0., 0.]
@test isapprox(project(Simplex(), y), fill(1//3, 3), rtol=1e-6)
end

end
