extends Node

class_name CombatConstants

const MAX_EMOTION_PTS = 20

enum EMOTIONS {BORED, HAPPY, CRINGE, OFFENDED, ANNOYED}
const NEUTRAL = -1

# String constants for easier editing in editor
const HAPPY = "happy"
const BORED = "bored"
const ANNOYED = "annoyed"
const OFFENDED = "offended"
const CRINGE = "cringe"

# String constants for personalities
const FROG = "frog"
const BORZOI = "borzoi"
const FERRET = "ferret"
const CAT = "cat"

enum ATTACK {COMPLIMENT, CHEER_ON, TELL_PUN, TELL_JOKE}

static func emotion_int_to_string(emotion: int) -> String:
	match emotion:
		EMOTIONS.HAPPY:
			return HAPPY
		EMOTIONS.BORED:
			return BORED
		EMOTIONS.OFFENDED:
			return OFFENDED
		EMOTIONS.CRINGE:
			return CRINGE
		EMOTIONS.ANNOYED:
			return ANNOYED
		_:
			return ""
