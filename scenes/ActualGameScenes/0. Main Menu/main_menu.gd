extends CanvasLayer

@export var next_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# Go to next scene
func _on_start_button_pressed():
	# change_scene_to_packed creates an instance of the next scene and changes
	# to it
	get_tree().change_scene_to_packed(next_scene)
