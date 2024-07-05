extends State

class_name EnemyIdleState

@export var attack_state : State
@export var idle_animation : String = "move"

func on_enter():
	playback.travel(idle_animation)

func _on_attack_area_body_entered(body):
	if body.is_in_group("Player"):
		can_move = true

func _on_attack_area_body_exited(body):
	if body.is_in_group("Player"):
		can_move = false

func _on_attack_body_entered(body):
	next_state = attack_state
