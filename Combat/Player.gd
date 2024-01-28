extends CharacterBody2D
class_name Player

@export var max_speed:int = 1000
@export var gravity : float = 55
@export var jump_force : int = 1600

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
	
	target.mod_emotion(CombatConstants.EMOTIONS.HAPPY, happy * 2)
	target.mod_emotion(CombatConstants.EMOTIONS.CRINGE, cringe - 1)
	target.mod_emotion(CombatConstants.EMOTIONS.ANNOYED, annoyed - 1)
	target.mod_emotion(CombatConstants.EMOTIONS.OFFENDED, offended - 1)
	
	var diff_happy = target.emotion_pts[CombatConstants.EMOTIONS.HAPPY] - happy
	var diff_annoyed = target.emotion_pts[CombatConstants.EMOTIONS.ANNOYED] - annoyed
	var diff_cringe = target.emotion_pts[CombatConstants.EMOTIONS.CRINGE] - cringe
	var diff_offended = target.emotion_pts[CombatConstants.EMOTIONS.OFFENDED] - offended
	target.mod_emotion(CombatConstants.EMOTIONS.BORED, target.emotion_pts[CombatConstants.EMOTIONS.BORED] - diff_happy - diff_annoyed - diff_cringe - diff_offended)
	
func tell_joke(target: Enemy):
	# H+1, C-1, A*2, O-1, B-1 - diffA
	var happy = target.emotion_pts[CombatConstants.EMOTIONS.HAPPY]
	var annoyed = target.emotion_pts[CombatConstants.EMOTIONS.ANNOYED]
	var cringe = target.emotion_pts[CombatConstants.EMOTIONS.CRINGE]
	var offended = target.emotion_pts[CombatConstants.EMOTIONS.OFFENDED]
	
	target.mod_emotion(CombatConstants.EMOTIONS.HAPPY, target.emotion_pts[CombatConstants.EMOTIONS.HAPPY] + 1)
	target.mod_emotion(CombatConstants.EMOTIONS.CRINGE, target.emotion_pts[CombatConstants.EMOTIONS.CRINGE] - 1)
	target.mod_emotion(CombatConstants.EMOTIONS.ANNOYED, annoyed * 2)
	target.mod_emotion(CombatConstants.EMOTIONS.OFFENDED, target.emotion_pts[CombatConstants.EMOTIONS.OFFENDED] - 1)
	
	var diff_happy = target.emotion_pts[CombatConstants.EMOTIONS.HAPPY] - happy
	var diff_annoyed = target.emotion_pts[CombatConstants.EMOTIONS.ANNOYED] - annoyed
	var diff_cringe = target.emotion_pts[CombatConstants.EMOTIONS.CRINGE] - cringe
	var diff_offended = target.emotion_pts[CombatConstants.EMOTIONS.OFFENDED] - offended
	
	target.mod_emotion(CombatConstants.EMOTIONS.BORED, target.emotion_pts[CombatConstants.EMOTIONS.BORED] - diff_happy - diff_annoyed - diff_cringe - diff_offended)

func cheer_on(target: Enemy):
	# H+2, C*2, A-1, O-2, B + 3 - diff H - diff C
	var happy = target.emotion_pts[CombatConstants.EMOTIONS.HAPPY]
	var annoyed = target.emotion_pts[CombatConstants.EMOTIONS.ANNOYED]
	var cringe = target.emotion_pts[CombatConstants.EMOTIONS.CRINGE]
	var offended = target.emotion_pts[CombatConstants.EMOTIONS.OFFENDED]
	
	target.mod_emotion(CombatConstants.EMOTIONS.HAPPY, target.emotion_pts[CombatConstants.EMOTIONS.HAPPY] + 2)
	target.mod_emotion(CombatConstants.EMOTIONS.CRINGE, cringe * 2)
	target.mod_emotion(CombatConstants.EMOTIONS.ANNOYED, target.emotion_pts[CombatConstants.EMOTIONS.ANNOYED] - 1)
	target.mod_emotion(CombatConstants.EMOTIONS.OFFENDED, target.emotion_pts[CombatConstants.EMOTIONS.OFFENDED] - 2)
	
	var diff_happy = target.emotion_pts[CombatConstants.EMOTIONS.HAPPY] - happy
	var diff_annoyed = target.emotion_pts[CombatConstants.EMOTIONS.ANNOYED] - annoyed
	var diff_cringe = target.emotion_pts[CombatConstants.EMOTIONS.CRINGE] - cringe
	var diff_offended = target.emotion_pts[CombatConstants.EMOTIONS.OFFENDED] - offended
	
	target.mod_emotion(CombatConstants.EMOTIONS.BORED, target.emotion_pts[CombatConstants.EMOTIONS.BORED] - diff_happy - diff_annoyed - diff_cringe - diff_offended)

func tell_pun(target: Enemy):
	# H+1, C-1, A*2, O-1, B -1 -diffA
	var happy = target.emotion_pts[CombatConstants.EMOTIONS.HAPPY]
	var annoyed = target.emotion_pts[CombatConstants.EMOTIONS.ANNOYED]
	var cringe = target.emotion_pts[CombatConstants.EMOTIONS.CRINGE]
	var offended = target.emotion_pts[CombatConstants.EMOTIONS.OFFENDED]
	
	target.mod_emotion(CombatConstants.EMOTIONS.HAPPY, target.emotion_pts[CombatConstants.EMOTIONS.HAPPY] + 1)
	target.mod_emotion(CombatConstants.EMOTIONS.CRINGE, target.emotion_pts[CombatConstants.EMOTIONS.CRINGE] - 1)
	target.mod_emotion(CombatConstants.EMOTIONS.ANNOYED, annoyed * 2)
	target.mod_emotion(CombatConstants.EMOTIONS.OFFENDED, target.emotion_pts[CombatConstants.EMOTIONS.OFFENDED] - 1)
	
	var diff_happy = target.emotion_pts[CombatConstants.EMOTIONS.HAPPY] - happy
	var diff_annoyed = target.emotion_pts[CombatConstants.EMOTIONS.ANNOYED] - annoyed
	var diff_cringe = target.emotion_pts[CombatConstants.EMOTIONS.CRINGE] - cringe
	var diff_offended = target.emotion_pts[CombatConstants.EMOTIONS.OFFENDED] - offended
	
	target.mod_emotion(CombatConstants.EMOTIONS.BORED, target.emotion_pts[CombatConstants.EMOTIONS.BORED] - diff_happy - diff_annoyed - diff_cringe - diff_offended)

func print_status():
	print("Morale:" + String.num(morale))

func string_status() -> String:
	return String.num(morale)


# ----------- MOVEMENT ------------ #
	
func _physics_process(_delta):
	
	if not is_on_floor():
		velocity.y += gravity
		if velocity.y > 2000:
			velocity.y = 2000
	
	if Input.is_action_pressed("move_right"):
		velocity.x = max_speed 
		$AnimatedSprite2D.flip_h = false
		
	elif Input.is_action_pressed("move_left"):
		velocity.x = -max_speed
		$AnimatedSprite2D.flip_h = true
	else:
		velocity.x = 0

	if Input.is_action_pressed("jump"):
		if is_on_floor():
			velocity.y = -jump_force

	move_and_slide()
