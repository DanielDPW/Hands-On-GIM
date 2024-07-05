extends CharacterBody2D

class_name Boss

@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine
@export var speed : float = 30

signal enemy_facing_direction_changed(facing_right : bool)

var player
var direction = Vector2.ZERO

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animation_tree.active = true
	player = get_tree().get_nodes_in_group("Player")[0]

func update_animation():
	animation_tree.set("parameters/move/blend_position", direction.x)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	if state_machine.check_if_can_move():
		if global_position.x > player.global_position.x:
			sprite.flip_h = true
			direction = Vector2.LEFT
		elif global_position.x < player.global_position.x:
			sprite.flip_h = false
			direction = Vector2.RIGHT
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		direction = Vector2.ZERO
	emit_signal("enemy_facing_direction_changed", !sprite.flip_h)
	move_and_slide()
	update_animation()
	


