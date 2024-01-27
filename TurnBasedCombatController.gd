extends Node

var player
var enemy


	
# Called when the node enters the scene tree for the first time.
func _ready():
	#$TurnBasedCombatUI/PlayerMood.text = ""
	pass # Replace with function body.
	

func init_scene(player_obj, enemy_obj):
	player = player_obj
	enemy = enemy_obj
	
	$TurnBasedCombatUI/PlayerMood.text = "Player mood: " + str(player.mood)
	$TurnBasedCombatUI/EnemyMood.text = "Enemy mood: " + str(player.mood)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_attack_pressed():
	print("Attack button pressed!")
