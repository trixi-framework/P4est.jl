using Test

# Assume that everything has been configured correctly via environment
# variables in CI and `configure_packages.jl`.
# From here on, all packages should be configured as desired and we can load
# everything and perform the tests.
using MPI: MPI, mpiexec
using P4est

import MPIPreferences
@info "Testing P4est.jl with" MPIPreferences.binary MPIPreferences.abi

@time @testset "P4est.jl tests" begin
    include("test_aqua.jl")
    # For some weird reason, the MPI tests must come first since they fail
    # otherwise with a custom MPI installation.
    @time @testset "MPI" begin
        # Do a dummy `@test true`:
        # If the process errors out the testset would error out as well,
        # cf. https://github.com/JuliaParallel/MPI.jl/pull/391
        @test true

        @info "Starting parallel tests"

        mpiexec() do cmd
            run(`$cmd -n 2 $(Base.julia_cmd()) --threads=1 --check-bounds=yes --project=$(dirname(@__DIR__)) $(abspath("tests_basic.jl"))`)
        end

        @info "Finished parallel tests"
    end

    @time @testset "serial" begin
        @info "Starting serial tests"

        include("tests_basic.jl")

        @info "Finished serial tests"
    end
end
