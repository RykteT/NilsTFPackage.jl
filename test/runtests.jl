using Test
using NilsTFPackage

@testset "AllTests" begin

    @testset "Addition" begin
        include("testAddition.jl")
    end # Addition

    @testset "Multiplication" begin
        include("testMultiplication.jl")
    end # Multiplication

    @testset "Division" begin
        include("testDivision.jl")
    end # Division

    @testset "Sqrt" begin
        include("testSqrt.jl")
    end # Sqrt

    @testset "Relation" begin
        include("testRelation.jl")
    end # Relation

    @testset "Composition" begin
        include("testComposition.jl")
    end # Composition

    @testset "Matrix" begin
        include("testMatrix.jl")
    end # Composition

end #AllTests
