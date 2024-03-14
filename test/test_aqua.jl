module TestAqua

using Aqua
using ExplicitImports: check_no_implicit_imports, check_no_stale_explicit_imports
using Test
using P4est

@testset "Aqua.jl" begin
    Aqua.test_all(P4est; unbound_args = false)
    @test isnothing(check_no_implicit_imports(P4est))
    @test isnothing(check_no_stale_explicit_imports(P4est; ignore=(:PointerWrapper,)))
end

end #module
