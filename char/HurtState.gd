extends State

class_name HurtState

@export var damageable : Damageable
@export var character_state_machine : CharacterStateMachine
@export var dead_state : State
@export var dead_animation : String = "die"
@export var knockback_speed : float = 100.0
@export var return_state : State
@export var blink_delay : float = 0.1

@onready var timer : Timer = $Timer

func _ready():
	damageable.connect("on_hit", on_damageable_hit)

func on_enter():
	timer.start()

func on_damageable_hit(node : Node, damage_taken : float, knockback_direction : Vector2):
	if damageable.health > 0:
		character.velocity = knockback_speed * knockback_direction
		emit_signal("interrupt_state", self)
		character.sprite.material.set_shader_parameter("mix_weight", 0.6)
		character.sprite.material.set_shader_parameter("whiten", true)
		await get_tree().create_timer(blink_delay).timeout
		character.sprite.material.set_shader_parameter("mix_weight", 1.0)
		character.sprite.material.set_shader_parameter("whiten", false)
	else:
		emit_signal("interrupt_state", dead_state)
		playback.travel(dead_animation)

func on_exit():
	character.velocity = Vector2.ZERO

func _on_timer_timeout():
	next_state = return_state
