# An example level! This starts the combat turn based level 
# by instantiating the the turned based combat scene with the player
# and enemy objects passed in.

# Here, example objects are used

extends Node2D

# Scene to preload
var combat_scene = preload("res://turn_based_combat_scene.tscn")
var player_scene = preload("res://scenes/Player.tscn")
var enemy_scene = preload("res://objects/enemy.tscn")

var player: Player
var enemy: Enemy
var combat_scene_instance

# Create example player and enemy objects
func _ready():
	player = player_scene.instantiate()
	enemy = enemy_scene.instantiate()
	
	enemy.personality = CombatConstants.FROG
	
	# Instantiate turn based combat scene
	combat_scene_instance = combat_scene.instantiate()
	combat_scene_instance.init_scene(player, enemy)
	add_child(combat_scene_instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
