extends State

@export var airattack1 : String = "airattack1"
@export var airattack2 : String = "airattack2"
@export var airattack3 : String = "airattack3"
@export var return_state : State
@export var airattack_animation : String = "airattack1"

@onready var timer : Timer = $Timer

func on_enter():
	playback.travel(airattack_animation)
	character.velocity.y = 0
	
func state_input(event : InputEvent):
	if(event.is_action_pressed("attack")):
		timer.start()

func _on_animation_tree_animation_finished(anim_name):
	if(anim_name == airattack1):
		if(timer.is_stopped()):
			next_state = return_state
			character.velocity.y = 0
		else:
			playback.travel(airattack2)
			character.velocity.y = 0
	if(anim_name == airattack2):
		if(timer.is_stopped()):
			next_state = return_state
			character.velocity.y = 0
		else:
			playback.travel(airattack3)
			character.velocity.y = 0
	if(anim_name == airattack3):
		next_state = return_state
