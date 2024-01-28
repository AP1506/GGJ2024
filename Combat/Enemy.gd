extends AnimatedSprite2D

class_name Enemy

@export var emotion_pts: Array = [0, 0, 0, 0, 0]

# Visuals
@export var default_animation: String

@export var personality: String

# Create EnemyCombat with the given personality type
func create_enemy_combat() -> EnemyCombat:
	var enemy = preload("res://objects/enemy_combat.tscn").instantiate()
	match personality:
		CombatConstants.FROG:
			enemy.set_script(preload("res://Combat/FrogEnemyCombat.gd"))
	
	enemy.copy_properties(self)
	
	return enemy
