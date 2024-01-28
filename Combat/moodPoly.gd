extends Polygon2D

# The max distance from the center, or point 1
var max_distance0
var max_distance2

# Called when the node enters the scene tree for the first time.
func _init():
	# Calculate max distances
	max_distance0 = polygon[0] - polygon[1]
	max_distance2 = polygon[2] - polygon[1]

# Resize to a fraction of the max size
func resize(fraction: float):
	if fraction == 0:
		visible = false
		return
	
	polygon[0] = polygon[1] + max_distance0 * fraction
	polygon[2] = polygon[1] + max_distance2 * fraction
	
	visible = true
