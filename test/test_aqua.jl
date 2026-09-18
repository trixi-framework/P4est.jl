module TestAqua

using Aqua: Aqua
using ExplicitImports: test_explicit_imports
using Test
using P4est

@testset "Aqua.jl" begin
    Aqua.test_all(P4est; unbound_args = false)
end

@testset "ExplicitImports.jl" begin
   test_explicit_imports(P4est)
end

end #module
