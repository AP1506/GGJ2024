# ** A temporarily hard coded script where if the player runs into the 
# enemy battle runs. **

extends Area2D

# Scene to preload
var combat_scene = preload("res://turn_based_combat_scene.tscn")
var player_scene = preload("res://scenes/Player.tscn")
var enemy_scene = preload("res://objects/enemy_combat.tscn")

var player
var enemy
var combat_scene_instance

func start_combat():
	print("Area entered")
	player = player_scene.instantiate()
	enemy = enemy_scene.instantiate()
	
	# Instantiate turn based combat scene
	combat_scene_instance = combat_scene.instantiate()
	combat_scene_instance.init_scene(player, enemy)

	#add_child(combat_scene_instance)

	# Remove the current level
	var root = get_tree().root
	var level = root.get_node("Level1")
	root.remove_child(level)
	level.call_deferred("free")

	# Change levels
	root.add_child(combat_scene_instance)


func _on_area_entered(area):
	start_combat()

func _on_body_entered(body):
	start_combat()
