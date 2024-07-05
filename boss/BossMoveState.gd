extends State

class_name BossMoveState

@export var attack_state : State
@export var idle_animation : String = "move"

func on_enter():
	playback.travel(idle_animation)


func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		can_move = true


func _on_area_2d_body_exited(body):
	if body.is_in_group("Player"):
		can_move = false
