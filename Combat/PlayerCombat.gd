extends AnimatedSprite2D

class_name PlayerCombat

# Signals that a single action was completed
signal action_ended

var morale: int = 20:
	set(value):
		if value >= 0:
			morale = value

func compliment(target: Enemy):
	# H*2, C-1, A-1, O-1, B + 3 - diff Happy
	var happy = target.emotion_pts[CombatConstants.EMOTIONS.HAPPY]
	var annoyed = target.emotion_pts[CombatConstants.EMOTIONS.ANNOYED]
	var cringe = target.emotion_pts[CombatConstants.EMOTIONS.CRINGE]
	var offended = target.emotion_pts[CombatConstants.EMOTIONS.OFFENDED]
	
	target.mod_emotion(CombatConstants.EMOTIONS.HAPPY, happy * 2 + 1)
	target.mod_emotion(CombatConstants.EMOTIONS.CRINGE, cringe - 1)
	target.mod_emotion(CombatConstants.EMOTIONS.ANNOYED, annoyed - 1 + (offended - 5))
	target.mod_emotion(CombatConstants.EMOTIONS.OFFENDED, offended - 1)
	
	var diff_happy = target.emotion_pts[CombatConstants.EMOTIONS.HAPPY] - happy
	var diff_annoyed = target.emotion_pts[CombatConstants.EMOTIONS.ANNOYED] - annoyed
	var diff_cringe = target.emotion_pts[CombatConstants.EMOTIONS.CRINGE] - cringe
	var diff_offended = target.emotion_pts[CombatConstants.EMOTIONS.OFFENDED] - offended
	target.mod_emotion(CombatConstants.EMOTIONS.BORED, target.emotion_pts[CombatConstants.EMOTIONS.BORED] - diff_happy - diff_annoyed - diff_cringe - diff_offended)
	
	play("hit_animation")
	
	target.connect_hit_animation(self)
	
func tell_joke(target: Enemy):
	# H+1, C-1, A*2, O-1, B-1 - diffA
	var happy = target.emotion_pts[CombatConstants.EMOTIONS.HAPPY]
	var annoyed = target.emotion_pts[CombatConstants.EMOTIONS.ANNOYED]
	var cringe = target.emotion_pts[CombatConstants.EMOTIONS.CRINGE]
	var offended = target.emotion_pts[CombatConstants.EMOTIONS.OFFENDED]
	
	target.mod_emotion(CombatConstants.EMOTIONS.HAPPY, happy + 1)
	target.mod_emotion(CombatConstants.EMOTIONS.CRINGE, cringe - 1)
	target.mod_emotion(CombatConstants.EMOTIONS.ANNOYED, annoyed * 2 + (offended - 5))
	target.mod_emotion(CombatConstants.EMOTIONS.OFFENDED, offended - 1)
	
	var diff_happy = target.emotion_pts[CombatConstants.EMOTIONS.HAPPY] - happy
	var diff_annoyed = target.emotion_pts[CombatConstants.EMOTIONS.ANNOYED] - annoyed
	var diff_cringe = target.emotion_pts[CombatConstants.EMOTIONS.CRINGE] - cringe
	var diff_offended = target.emotion_pts[CombatConstants.EMOTIONS.OFFENDED] - offended
	
	target.mod_emotion(CombatConstants.EMOTIONS.BORED, target.emotion_pts[CombatConstants.EMOTIONS.BORED] - diff_happy - diff_annoyed - diff_cringe - diff_offended)
	
	play("hit_animation")
	
	target.connect_hit_animation(self)

func cheer_on(target: Enemy):
	# H+2, C*2, A-1, O-2, B + 3 - diff H - diff C
	var happy = target.emotion_pts[CombatConstants.EMOTIONS.HAPPY]
	var annoyed = target.emotion_pts[CombatConstants.EMOTIONS.ANNOYED]
	var cringe = target.emotion_pts[CombatConstants.EMOTIONS.CRINGE]
	var offended = target.emotion_pts[CombatConstants.EMOTIONS.OFFENDED]
	
	target.mod_emotion(CombatConstants.EMOTIONS.HAPPY, happy + 2)
	target.mod_emotion(CombatConstants.EMOTIONS.CRINGE, cringe * 2)
	target.mod_emotion(CombatConstants.EMOTIONS.ANNOYED, annoyed - 1 + (offended - 5))
	target.mod_emotion(CombatConstants.EMOTIONS.OFFENDED, offended - 2)
	
	var diff_happy = target.emotion_pts[CombatConstants.EMOTIONS.HAPPY] - happy
	var diff_annoyed = target.emotion_pts[CombatConstants.EMOTIONS.ANNOYED] - annoyed
	var diff_cringe = target.emotion_pts[CombatConstants.EMOTIONS.CRINGE] - cringe
	var diff_offended = target.emotion_pts[CombatConstants.EMOTIONS.OFFENDED] - offended
	
	target.mod_emotion(CombatConstants.EMOTIONS.BORED, target.emotion_pts[CombatConstants.EMOTIONS.BORED] - diff_happy - diff_annoyed - diff_cringe - diff_offended)
	
	play("hit_animation")
	
	target.connect_hit_animation(self)

func tell_pun(target: Enemy):
	# H+1, C-1, A*2, O-1, B -1 -diffA
	var happy = target.emotion_pts[CombatConstants.EMOTIONS.HAPPY]
	var annoyed = target.emotion_pts[CombatConstants.EMOTIONS.ANNOYED]
	var cringe = target.emotion_pts[CombatConstants.EMOTIONS.CRINGE]
	var offended = target.emotion_pts[CombatConstants.EMOTIONS.OFFENDED]
	
	target.mod_emotion(CombatConstants.EMOTIONS.HAPPY, happy + 1)
	target.mod_emotion(CombatConstants.EMOTIONS.CRINGE, cringe + 1)
	target.mod_emotion(CombatConstants.EMOTIONS.ANNOYED, annoyed * 2 + (offended - 5))
	target.mod_emotion(CombatConstants.EMOTIONS.OFFENDED, offended - 1)
	
	var diff_happy = target.emotion_pts[CombatConstants.EMOTIONS.HAPPY] - happy
	var diff_annoyed = target.emotion_pts[CombatConstants.EMOTIONS.ANNOYED] - annoyed
	var diff_cringe = target.emotion_pts[CombatConstants.EMOTIONS.CRINGE] - cringe
	var diff_offended = target.emotion_pts[CombatConstants.EMOTIONS.OFFENDED] - offended
	
	target.mod_emotion(CombatConstants.EMOTIONS.BORED, target.emotion_pts[CombatConstants.EMOTIONS.BORED] - diff_happy - diff_annoyed - diff_cringe - diff_offended)
	
	play("hit_animation")
	
	target.connect_hit_animation(self)

func print_status():
	print("Morale:" + String.num(morale))

func string_status() -> String:
	return String.num(morale)

func connect_hit_animation(attacker: Enemy):
	attacker.animation_finished.connect(_on_hit, 4)

func _on_hit():
	$AnimationPlayer.play("hit1")
	
	$AnimationPlayer.animation_finished.connect(_on_finished_hit2, 4)

func _on_finished_hit():
	action_ended.emit()

func _on_finished_hit2(anim_name):
	action_ended.emit()
