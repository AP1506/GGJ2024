extends Node

class_name Enemy

@export var emotion_pts: Array = [0, 0, 0, 0, 0]
var curr_emotion: int = -1

func _ready():
	update_curr_emotion()

func attack(target: Player):
	target.morale -= 2

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
		
