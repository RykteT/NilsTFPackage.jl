
v1 = TrackingFloat(1)
v2 = TrackingFloat(2)
v3 = TrackingFloat(3, 3)
v4 = TrackingFloat(4)

@test v1*v2 - v3  == TrackingFloat(-1, 3)
@test -v4         == TrackingFloat(-4, 0)
@test sqrt(v4)*v2 == TrackingFloat(4, 4)
