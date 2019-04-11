module NilsTFPackage

@show VERSION
import Base: +, -, *, /, <, sqrt, promote_rule, convert
using Test

struct TrackingFloat <: AbstractFloat
    val::Float64
    mem::Float64
end

function new_mem(a::T...) where {T <: Number}
    return maximum(abs, a)
end

function TrackingFloat(val::Number) return TrackingFloat(val, 0.0) end
function TrackingFloat(tf::TrackingFloat) return tf end

function getval(tf::TrackingFloat) return tf.val end

function getmax(tf::TrackingFloat) return tf.mem end

function *(tf1::TrackingFloat, tf2::TrackingFloat)
    return TrackingFloat(tf1.val*tf2.val, new_mem(tf1.val, tf1.mem, tf2.val, tf2.mem))
end

function +(tf1::TrackingFloat, tf2::TrackingFloat)
    return TrackingFloat(tf1.val+tf2.val, new_mem(tf1.val, tf1.mem, tf2.val, tf2.mem))
end

function -(tf1::TrackingFloat, tf2::TrackingFloat)
    return TrackingFloat(tf1.val-tf2.val, new_mem(tf1.val, tf1.mem, tf2.val, tf2.mem))
end

function /(tf1::TrackingFloat, tf2::TrackingFloat)
    return TrackingFloat(tf1.val/tf2.val, new_mem(tf1.val, tf1.mem, tf2.val, tf2.mem, 1/tf2.val))
end

function <(tf1::TrackingFloat, tf2::TrackingFloat)
    return tf1.val < tf2.val
end

function sqrt(tf::TrackingFloat)
    return TrackingFloat(sqrt(tf.val), new_mem(tf.val, tf.mem))
end

function -(tf::TrackingFloat)
    return TrackingFloat(-tf.val, tf.mem)
end

function convert(::Type{TrackingFloat}, x::Number) return TrackingFloat(x) end
function promote_rule(::Type{T}, ::Type{TrackingFloat}) where {T <: Number} return TrackingFloat end



# ----------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------
# NOTE: Test code
#################### Part 1 simple operations
# Test your type
v = TrackingFloat(1.0) + TrackingFloat(3.0) 
@test v == TrackingFloat(4, 3)                           # We expect TrackingFloat(4, 3)
@test v*v == TrackingFloat(16, 4)                        # We expect TrackingFloat(16, 4)
@test v - v == TrackingFloat(0, 4)                       # We expect TrackingFloat(0, 4)
@test v/TrackingFloat(0.1, 0) == TrackingFloat(40, 10)   # We expect TrackingFloat(40, 10)
@test 1 + v == TrackingFloat(5, 4)                       # We expect TrackingFloat(5, 4)
@test v - 1 == TrackingFloat(3, 4)                       # We expect TrackingFloat(3, 4)
@test v / 2 == TrackingFloat(2, 4)                       # We expect TrackingFloat(2, 4)
@test sqrt(v) == TrackingFloat(2, 4)                     # We expect TrackingFloat(2, 4)
@test sqrt(v) < v                                        # We expect True

# Try working with matrices
A = randn(10,10)
b = randn(10)

# Convert using broadcast
At = TrackingFloat.(A)
bt = TrackingFloat.(b)

# Try some operations
v = A*b
vt = At*bt
# Did we calculate correctly? Using getval to convert back to float
println(maximum(abs, v - getval.(vt)))

# Get the max fields using our function getmax
println(getmax.(vt))

#################### Part 2: Lets try something more complicated
using LinearAlgebra

# Is promotion working?
@test TrackingFloat(1.0, 0) + 2.0 == TrackingFloat(3, 2) # Expect TrackingFloat(3, 2)

# Create Positive definite matrix
AA = A*A'
# Convert to TrackingFloat matrix
AAt = TrackingFloat.(AA)

sol1 = AAt\bt # Uses qr
# Did we get the correct answer?
println(maximum(abs, getval.(sol1) - AA\b))

# Try cholesky factorization
F = cholesky(AAt)

sol2 = F\bt
println(maximum(abs, getval.(sol2) - AA\b))

# Which method was able to work with smallest elements?
println(maximum(getmax.(sol1)))
println(maximum(getmax.(sol2)))

####### Optional part
# This can be a bit trickier, so it is completely optional:
# Make TrackingFloat parametric, e.g
# TrackingFloat{T<:Real}, so that
# TrackingFloat{Int64} + TrackingFloat{Int64} isa TrackingFloat{Int64}
# Can you make the following work too?
# TrackingFloat{Int64} + TrackingFloat{Float64} isa TrackingFloat{Float64})))
end # module
