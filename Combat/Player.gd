extends CharacterBody2D
class_name Player

@export var max_speed:int = 1000
@export var gravity : float = 55
@export var jump_force : int = 1600

# ----------- MOVEMENT ------------ #
	
func _physics_process(_delta):
	
	if not is_on_floor():
		velocity.y += gravity
		if velocity.y > 2000:
			velocity.y = 2000
	
	if Input.is_action_pressed("move_right"):
		velocity.x = max_speed 
		$AnimatedSprite2D.flip_h = false
		
	elif Input.is_action_pressed("move_left"):
		velocity.x = -max_speed
		$AnimatedSprite2D.flip_h = true
	else:
		velocity.x = 0

	if Input.is_action_pressed("jump"):
		if is_on_floor():
			velocity.y = -jump_force

	move_and_slide()
