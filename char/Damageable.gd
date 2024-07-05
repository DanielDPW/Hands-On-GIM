extends Node

class_name Damageable

@export var healthbar : ProgressBar
@export var health : float = 20
@export var dead_animation : String = "die"

var is_blinking = false

func _ready():
	healthbar.init_health(health)

signal on_hit(node : Node, damage_taken : float, knockback_direction : Vector2)

func hit(damage : float, knockback_direction : Vector2):
	health = health - damage
	if health >= 0:
		healthbar.health = health
		emit_signal("on_hit", get_parent(), damage, knockback_direction)
	

func _on_animation_tree_animation_finished(anim_name):
	if(anim_name == dead_animation):
		get_parent().queue_free()
