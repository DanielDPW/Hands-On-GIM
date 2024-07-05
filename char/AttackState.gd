extends State

@export var attack1 : String = "attack1"
@export var attack2 : String = "attack2"
@export var attack3 : String = "attack3"
@export var return_state : State
@export var attack_animation : String = "attack1"

@onready var timer : Timer = $Timer

func on_enter():
	playback.travel(attack_animation)
	
func state_input(event : InputEvent):
	if(event.is_action_pressed("attack")):
		timer.start()

func _on_animation_tree_animation_finished(anim_name):
	if(anim_name == attack1):
		if(timer.is_stopped()):
			next_state = return_state
		else:
			playback.travel(attack2)
	if(anim_name == attack2):
		if(timer.is_stopped()):
			next_state = return_state
		else:
			playback.travel(attack3)
	if(anim_name == attack3):
		next_state = return_state
