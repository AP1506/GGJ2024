extends EnemyCombat

func disgust(target: PlayerCombat):
	target.mod_emotion(CombatConstants.EMOTIONS.CRINGE, target.emotion_pts[CombatConstants.EMOTIONS.CRINGE] + 2)
