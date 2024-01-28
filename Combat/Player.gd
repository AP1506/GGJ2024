extends CharacterBody2D
class_name Player

@export var max_speed:int = 1000
@export var gravity : float = 55
@export var jump_force : int = 1600

var camera2d
var init_camera_x_pos

func _ready():
	camera2d = $PlayerCamera
	init_camera_x_pos = camera2d.global_position.x
	
func _process(delta):
	# Fix the Camera2D in the x-direction
	#var new_offset = Vector2(global_position.x, camera2d.offset.y)
	#camera2d.offset = new_offset
	
	$PlayerCamera.global_position.x = init_camera_x_pos
	
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
