
v1 = TrackingFloat(1.0)
v2 = TrackingFloat(3.0)
v  = TrackingFloat(4.0, 3.0)

@test v       == TrackingFloat(1.0) + TrackingFloat(3.0) 
@test v       == v1 + v2
@test v       == v2 + 1
@test v2 - v1 == TrackingFloat(2, 3)
@test v2 - 1  == TrackingFloat(2, 3)
