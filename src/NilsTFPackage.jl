module NilsTFPackage

import Base: +, -, *, /, <, sqrt, promote_rule, convert

export TrackingFloat

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

end # module
