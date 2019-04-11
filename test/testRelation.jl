
v1 = TrackingFloat(1.0)
v2 = TrackingFloat(3.0)
v  = TrackingFloat(4.0, 3.0)

@test v1 < v2
@test v2 < v
@test v < TrackingFloat(8)
