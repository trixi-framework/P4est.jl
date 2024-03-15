module TestAqua

using Aqua
using Test
using P4est

@testset "Aqua.jl" begin
    Aqua.test_all(P4est; unbound_args = false)
end

end #module
