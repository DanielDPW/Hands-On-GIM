extends State

class_name AirState

@export var ground_state : State
@export var double_jump_velocity : float = -300
@export var double_jump_animation : String = "somersault"
@export var airattack_state : State
@export var air_animation : String = "fall"

var has_double_jumped = false

func on_enter():
	playback.travel(air_animation)

func state_process(delta):
	if(character.is_on_floor()):
		next_state = ground_state

func state_input(event : InputEvent):
	if(event.is_action_pressed("up") && !has_double_jumped):
		double_jump()
	if(event.is_action_pressed("attack")):
		airattack()

func on_exit():
	if(next_state == ground_state):
		has_double_jumped = false

func double_jump():
	playback.travel(double_jump_animation)
	character.velocity.y = double_jump_velocity
	has_double_jumped = true
	
func airattack():
	next_state = airattack_state

