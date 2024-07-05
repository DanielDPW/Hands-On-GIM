extends Node2D

@onready var dash_duration = $DashDuration
@onready var ghost_timer = $GhostTimer

@export var dash_delay : float = 0.5
@export var player : Player

var sprite
var dash_ghost = preload("res://char/dash_ghost.tscn")
var can_dash : bool = true

 
func instance_dash_ghost():
	var ghost: Sprite2D = dash_ghost.instantiate()
	get_tree().root.add_child(ghost)
	ghost.global_position = player.global_position #Self explanatory
	ghost.texture = sprite.texture
	ghost.scale = sprite.scale
	ghost.vframes = sprite.vframes
	ghost.hframes = sprite.hframes
	ghost.frame = sprite.frame
	ghost.flip_h = sprite.flip_h

func start_dash(duration):
	sprite = player.sprite
	player.sprite.material.set_shader_parameter("mix_weight", 0.7)
	player.sprite.material.set_shader_parameter("whiten", true)
	dash_duration.wait_time = duration
	dash_duration.start()
	ghost_timer.start()
	instance_dash_ghost()

func is_dashing():
	return !dash_duration.is_stopped()

func end_dash():
	ghost_timer.stop()
	player.sprite.material.set_shader_parameter("mix_weight", 1)
	player.sprite.material.set_shader_parameter("whiten", false)
	can_dash = false
	await get_tree().create_timer(dash_delay).timeout
	can_dash = true

func _on_dash_duration_timeout():
	end_dash()

func _on_ghost_timer_timeout():
	instance_dash_ghost()
