module BoxTest

using Projections, Test

@testset "box" begin
y = [-2.5, -1.5, -0.5, 0.0, 0.5, 1.5, 2.5]
a = fill(-1.0, length(y))
b = fill(1.0, length(y))
@test all(project(Box(a, b), y) .== [clamp(y[i], a[i], b[i]) for i in 1:length(y)])
end

end