extends Node

class_name Enemy

var emotion_pts: Array = [0, 0, 0, 0, 0]
var curr_emotion: int

func _ready():
	pass
	
func attack(target: Player):
	target.morale -= 2

func mod_emotion(emotion: int, new_value):
	if new_value >= 0:
		emotion_pts[emotion] = new_value

func update_curr_emotion():
	# Find the max emotion
	var max = 0
	var max_emotion = 0
	
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
	return "" 
