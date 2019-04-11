
v1 = TrackingFloat(0.1)
v2 = TrackingFloat(3.0)
v  = TrackingFloat(4.0, 3.0)

@test v / 2   == TrackingFloat(2, 4)
@test 2 / v   == TrackingFloat(0.5, 4)
@test v2 / v1 == TrackingFloat(30, 10)
