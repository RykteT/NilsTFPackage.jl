A = [1, 2, 3; 4, 5, 6; 7, 8, 9]
b = ones(3)

# Convert using broadcast
At = TrackingFloat.(A)
bt = TrackingFloat.(b)

# Try some operations
vt = At*bt

@test vt == TrackingFloat.([6, 15, 24])
