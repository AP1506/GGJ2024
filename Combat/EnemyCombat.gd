extends AnimatedSprite2D

class_name EnemyCombat

# Signals that a single action was completed
signal action_ended

@export var emotion_pts: Array = [0, 0, 0, 0, 0]
var curr_emotion: int = -1

### Visuals ###
@export var default_animation: String
# Played by AnimationPlayer
@export var hit_animation: String
# Played by AnimationPlayer
@export var attack_animation1: String
@export var attack_animation2: String

@export var personality: String

func _init():
	update_curr_emotion()

func attack(target: PlayerCombat):
	target.morale -= 1
	$AnimationPlayer.play(attack_animation1)
	
	target.connect_hit_animation(self)

# Copy important properties from explore Enemy
func copy_properties(enemy: Enemy):
	emotion_pts = enemy.emotion_pts
	
	update_curr_emotion()
	
	personality = enemy.personality
	
	default_animation = personality + "_default"
	play(default_animation)
	
	match personality:
		#CombatConstants.BORZOI:
			#attack_animation1 = "attack_animation_" + personality
		_:
			attack_animation1 = "attack_animation1"
	
	hit_animation = "hit_animation"

func mod_emotion(emotion: int, new_value):
	if new_value >= 0 && new_value <= 20:
		emotion_pts[emotion] = new_value
		update_curr_emotion()
	elif new_value > 20:
		emotion_pts[emotion] = 20
		update_curr_emotion()

func update_curr_emotion():
	# Find the max emotion
	var max = 0
	var max_emotion = -1
	
	for i in range(len(emotion_pts)):
		if emotion_pts[i] > max:
			max = emotion_pts[i]
			max_emotion = i
	
	curr_emotion = max_emotion
	
	if curr_emotion != CombatConstants.NEUTRAL:
		default_animation = personality + "_default_" + CombatConstants.emotion_int_to_string(curr_emotion)
	else:
		default_animation = personality + "_default"

func print_status():
	print("Happy:" + String.num(emotion_pts[CombatConstants.EMOTIONS.HAPPY]))
	print("Annoyed:" + String.num(emotion_pts[CombatConstants.EMOTIONS.ANNOYED]))
	print("Cringe:" + String.num(emotion_pts[CombatConstants.EMOTIONS.CRINGE]))
	print("Offended:" + String.num(emotion_pts[CombatConstants.EMOTIONS.OFFENDED]))
	print("Bored:" + String.num(emotion_pts[CombatConstants.EMOTIONS.BORED]))

func string_status() -> String:
	return "H:" + String.num(emotion_pts[CombatConstants.EMOTIONS.HAPPY]) + \
	" A:" + String.num(emotion_pts[CombatConstants.EMOTIONS.ANNOYED]) + \
	" C:" + String.num(emotion_pts[CombatConstants.EMOTIONS.CRINGE]) + \
	" O:" + String.num(emotion_pts[CombatConstants.EMOTIONS.OFFENDED]) + \
	" B:" + String.num(emotion_pts[CombatConstants.EMOTIONS.BORED])
	
func string_curr_mood() -> String:
	match curr_emotion:
		CombatConstants.EMOTIONS.BORED:
			return "BORED"
		CombatConstants.EMOTIONS.HAPPY:
			return "HAPPY"
		CombatConstants.EMOTIONS.CRINGE:
			return "CRINGING"
		CombatConstants.EMOTIONS.OFFENDED:
			return "OFFENDED"
		CombatConstants.EMOTIONS.ANNOYED:
			return "ANNOYED"
		_:
			return "NEUTRAL"
		
func connect_hit_animation(attacker: PlayerCombat):
	attacker.animation_finished.connect(_on_hit, 4)

func _on_hit():
	$AnimationPlayer.play(hit_animation)
	
	$AnimationPlayer.animation_finished.connect(_on_finished_hit2, 4)

func _on_finished_hit():
	action_ended.emit()
	play(default_animation)

func _on_finished_hit2(anim_name):
	action_ended.emit()
