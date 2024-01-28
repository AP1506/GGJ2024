extends Node

var player: Player
var enemy: Enemy

var player_combat: PlayerCombat
var enemy_combat: Enemy

var target: Enemy

var is_player_turn: bool

# Controls when to start next turn
var start_next_turn: bool
	
# Called when the node enters the scene tree for the first time.
func _ready():
	#$TurnBasedCombatUI/PlayerMood.text = ""
	
	var attack_buttons = [$AllUI/TurnBasedCombatUI/AttackOptionsUI/Attack1, $AllUI/TurnBasedCombatUI/AttackOptionsUI/Attack2, $AllUI/TurnBasedCombatUI/AttackOptionsUI/Attack3, $AllUI/TurnBasedCombatUI/AttackOptionsUI/Attack4]
	
	attack_buttons[0].pressed.connect(_on_specific_attack_pressed.bind(attack_buttons[0].attack))
	attack_buttons[1].pressed.connect(_on_specific_attack_pressed.bind(attack_buttons[1].attack))
	attack_buttons[2].pressed.connect(_on_specific_attack_pressed.bind(attack_buttons[2].attack))
	attack_buttons[3].pressed.connect(_on_specific_attack_pressed.bind(attack_buttons[3].attack))
	

func init_scene(player_obj, enemy_obj):
	player = player_obj
	enemy = enemy_obj
	
	player_combat = $Entities/PlayerCombat
	enemy_combat = $Entities/EnemyCombat
	
	# Connecting action end to change of turn
	player_combat.action_ended.connect(_on_action_ended)
	enemy_combat.action_ended.connect(_on_action_ended)
	
	target = enemy_combat
	
	is_player_turn = true
	
	update_ui_player()
	update_ui_enemy(enemy_combat)
	
	var attack_buttons = [$AllUI/TurnBasedCombatUI/AttackOptionsUI/Attack1, $AllUI/TurnBasedCombatUI/AttackOptionsUI/Attack2, $AllUI/TurnBasedCombatUI/AttackOptionsUI/Attack3, $AllUI/TurnBasedCombatUI/AttackOptionsUI/Attack4]
	# Change attack names
	attack_buttons[CombatConstants.ATTACK.COMPLIMENT].attack = CombatConstants.ATTACK.COMPLIMENT
	attack_buttons[CombatConstants.ATTACK.COMPLIMENT].text = "Compliment"
	
	attack_buttons[CombatConstants.ATTACK.CHEER_ON].attack = CombatConstants.ATTACK.CHEER_ON
	attack_buttons[CombatConstants.ATTACK.CHEER_ON].text = "Cheer on"
	
	attack_buttons[CombatConstants.ATTACK.TELL_JOKE].attack = CombatConstants.ATTACK.TELL_JOKE
	attack_buttons[CombatConstants.ATTACK.TELL_JOKE].text = "Tell joke"
	
	attack_buttons[CombatConstants.ATTACK.TELL_PUN].attack = CombatConstants.ATTACK.TELL_PUN
	attack_buttons[CombatConstants.ATTACK.TELL_PUN].text = "Tell pun"
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if start_next_turn:
		start_next_turn = false
		
		if is_player_turn:
			play_player_turn()
		else:
			play_enemy_turn(enemy)

func update_ui_player():
	$AllUI/TurnBasedCombatUI/PlayerMood.text = "Player morale: " + player_combat.string_status()

func update_ui_enemy(enemy: Enemy):
	$AllUI/TurnBasedCombatUI/EnemyMood.text = "Enemy mood: " + enemy_combat.string_status()
	$AllUI/TurnBasedCombatUI/EnemyCurrMood.text = "Enemy mood: " + enemy_combat.string_curr_mood()

func play_player_turn():
	$AllUI/TurnBasedCombatUI/ColorRect.visible = true
	$AllUI/TurnBasedCombatUI/OptionsUI.visible = true
	$AllUI/TurnBasedCombatUI/AttackOptionsUI.visible = false
	
	# Wait for signal that player made a choice

func play_enemy_turn(enemy: Enemy):
	$AllUI/TurnBasedCombatUI/ColorRect.visible = false
	$AllUI/TurnBasedCombatUI/OptionsUI.visible = false
	$AllUI/TurnBasedCombatUI/AttackOptionsUI.visible = false
	
	enemy_combat.attack(player_combat)
	
	update_ui_player()

func _on_attack_pressed():
	$AllUI/TurnBasedCombatUI/OptionsUI.visible = false
	$AllUI/TurnBasedCombatUI/AttackOptionsUI.visible = true
	print("Attack button pressed!")

func _on_run_away_pressed():
	print("Run away button pressed")

func _on_specific_attack_pressed(attack: int):
	print("Attack" +  String.num(attack))
	
	match attack:
		CombatConstants.ATTACK.COMPLIMENT:
			player_combat.compliment(target)
		CombatConstants.ATTACK.CHEER_ON:
			player_combat.cheer_on(target)
		CombatConstants.ATTACK.TELL_PUN:
			player_combat.tell_pun(target)
		CombatConstants.ATTACK.TELL_JOKE:
			player_combat.tell_joke(target)
	
	update_ui_enemy(target)
	
	# Disable UI options while attack is being undergone
	$AllUI/TurnBasedCombatUI/ColorRect.visible = false
	$AllUI/TurnBasedCombatUI/OptionsUI.visible = false
	$AllUI/TurnBasedCombatUI/AttackOptionsUI.visible = false

func _on_action_ended():
	start_next_turn = true
	is_player_turn = not is_player_turn
