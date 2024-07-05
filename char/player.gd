extends CharacterBody2D

class_name Player

@export var move_speed : float = 200.0
@export var dash_speed : float = 600.0
@export var dash_duration : float = 0.2
@export var hurt_state : HurtState

@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine
@onready var dash = $Dash

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : Vector2 = Vector2.ZERO
var playback : AnimationNodeStateMachinePlayback

signal facing_direction_changed(facing_right : bool)

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	if Input.is_action_just_pressed("dash") && !dash.is_dashing() && dash.can_dash && direction.x != 0 && state_machine.check_if_can_move():
		dash.start_dash(dash_duration)
	var speed = dash_speed if dash.is_dashing() else move_speed
	if not is_on_floor():
		velocity.y += gravity * delta
	direction = Input.get_vector("left", "right", "up", "down")

	if direction.x != 0 && state_machine.check_if_can_move():
		velocity.x = direction.x * speed
	elif (state_machine.current_state != hurt_state):
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	update_animation_parameters()
	update_facing_direction()
	
func update_animation_parameters():
	animation_tree.set("parameters/move/blend_position", direction.x)

func update_facing_direction():
	if direction.x > 0:
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.flip_h = true
	emit_signal("facing_direction_changed", !sprite.flip_h)
	

