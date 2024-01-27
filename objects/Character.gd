extends Node2D

var max_health = 100
var current_health = max_health

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func take_damage(amount):
	current_health -= amount
	if current_health <= 0:
		current_health = 0
		# Player is defeated - handle game over or other logic here
