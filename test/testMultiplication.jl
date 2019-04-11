
v1 = TrackingFloat(1.0)
v2 = TrackingFloat(3.0)
v  = TrackingFloat(4.0, 3.0)

@test v*v        == TrackingFloat(16, 4)
@test v1*v2      == TrackingFloat(3, 3)
@test (v1*v2)*v3 == TrackingFloat(12, 4)
@test 4v         == TrackingFloat(16, 4)
@test v*6        == TrackingFloat(24, 6)
