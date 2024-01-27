extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var resource = preload("res://dialogues/dialogue.dialogue")
	DialogueManager.show_example_dialogue_balloon(resource)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func move_over_there() -> void:
	$Character/AnimationPlayer.play("new_animation")
	await($Character/AnimationPlayer)
