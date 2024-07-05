extends State

class_name EnemyAttackState

@export var damage : float = 10.0
@export var idle_state : State
@export var attack_animation : String = "attack"
@export var attack : Area2D


func on_enter():
	playback.travel(attack_animation)


func _on_animation_tree_animation_finished(anim_name):
	if anim_name == attack_animation:
		next_state = idle_state
