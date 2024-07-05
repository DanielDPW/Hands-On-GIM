extends State

class_name GroundState

@export var jump_velocity : float = -350.0
@export var air_state : State
@export var jump_animation : String = "jump"
@export var attack_state : State
@export var ground_animation : String = "move"

func on_enter():
	playback.travel(ground_animation)
	
func state_process(delta):
	if(!character.is_on_floor()):
		next_state = air_state

func state_input(event : InputEvent):
	if(event.is_action_pressed("up")):
		jump()
	if(event.is_action_pressed("attack")):
		attack()
	
func jump():
	character.velocity.y = jump_velocity
	playback.travel(jump_animation)

func attack():
	next_state = attack_state
