module TestAqua

using Aqua: Aqua
using ExplicitImports: test_explicit_imports
using Test
using P4est

@testset "Aqua.jl" begin
    # in case we are running with system MPI P4est_jll will not be loaded
    if JULIA_MPI_PROVIDER == "P4EST_CUSTOM_MPI_CUSTOM"
        stale_deps_ignore = (ignore = [:P4est_jll],)
    else
        stale_deps_ignore = ()
    end
    Aqua.test_all(P4est; unbound_args = false,
                  stale_deps = stale_deps_ignore)
end

@testset "ExplicitImports.jl" begin
    test_explicit_imports(P4est;
                          # We use `MPI_Comm`, `MPI_Datatype`, `MPI_File`, and `MPI_Group`, which are non-public
                          all_explicit_imports_are_public = false,
                          # We use `MPIPreferences.binary`, which is non-public
                          all_qualified_accesses_are_public = false,
                          # We use `P4est.version()`
                          no_self_qualified_accesses = false)
end

end #module
