extends Area2D


@export var damage : float = 10.0
@export var enemy : Enemy
@export var enemy_hitbox : EnemyFacingShapeCollision2D
@export var attack_state : State

func _ready():
	enemy.connect("enemy_facing_direction_changed", _on_enemy_facing_direction_changed)
func _on_body_entered(body):
	for child in body.get_children():
		if child is Damageable:
			var direction_to_damageable = (body.global_position - get_parent().global_position)
			var direction_sign = sign(direction_to_damageable.x)
			if direction_sign > 0:
				child.hit(damage, Vector2.RIGHT)
			elif direction_sign < 0:
				child.hit(damage, Vector2.LEFT)
			elif direction_sign == 0:
				child.hit(damage, Vector2.RIGHT)
				
func _on_enemy_facing_direction_changed(facing_right : bool):
	if(facing_right):
		enemy_hitbox.position = enemy_hitbox.facing_right_direction
	else:
		enemy_hitbox.position = enemy_hitbox.facing_left_direction

