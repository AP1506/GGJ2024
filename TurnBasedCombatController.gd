extends Node

var player
var enemy
var target: Enemy

var is_player_turn: bool

# Controls when to start next turn
var start_next_turn: bool
	
# Called when the node enters the scene tree for the first time.
func _ready():
	#$TurnBasedCombatUI/PlayerMood.text = ""
	
	var attack_buttons = [$TurnBasedCombatUI/AttackOptionsUI/Attack1, $TurnBasedCombatUI/AttackOptionsUI/Attack2, $TurnBasedCombatUI/AttackOptionsUI/Attack3, $TurnBasedCombatUI/AttackOptionsUI/Attack4]
	
	attack_buttons[0].pressed.connect(_on_specific_attack_pressed.bind(attack_buttons[0].attack))
	attack_buttons[1].pressed.connect(_on_specific_attack_pressed.bind(attack_buttons[1].attack))
	attack_buttons[2].pressed.connect(_on_specific_attack_pressed.bind(attack_buttons[2].attack))
	attack_buttons[3].pressed.connect(_on_specific_attack_pressed.bind(attack_buttons[3].attack))
	

func init_scene(player_obj, enemy_obj):
	player = player_obj
	enemy = enemy_obj
	target = enemy
	
	is_player_turn = true
	
	update_ui_player()
	update_ui_enemy(enemy)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if start_next_turn:
		start_next_turn = false
		
		if is_player_turn:
			play_player_turn()
		else:
			play_enemy_turn(enemy)

func update_ui_player():
	$TurnBasedCombatUI/PlayerMood.text = "Player mood: " + player.string_status()

func update_ui_enemy(enemy: Enemy):
	$TurnBasedCombatUI/EnemyMood.text = "Enemy mood: " + str(player.morale)

func play_player_turn():
	$TurnBasedCombatUI/OptionsUI.visible = true

func play_enemy_turn(enemy: Enemy):
	$TurnBasedCombatUI/ColorRect.visible = false
	$TurnBasedCombatUI/OptionsUI.visible = false
	$TurnBasedCombatUI/AttackOptionsUI.visible = false
	
	enemy.attack(player)
	
	update_ui_player()
	
	is_player_turn = true

func _on_attack_pressed():
	$TurnBasedCombatUI/OptionsUI.visible = false
	$TurnBasedCombatUI/AttackOptionsUI.visible = true
	print("Attack button pressed!")

func _on_run_away_pressed():
	print("Run away button pressed")

func _on_specific_attack_pressed(attack: int):
	start_next_turn = true
	is_player_turn = false
	print("Attack" +  String.num(attack))
