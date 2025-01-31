extends Boss


@export var move_speed: float = 100.0


func _on_small_star_died() -> void:
	pass


# MOVE IDLE STATE

func _on_idle_state_entered() -> void:
	var dir_to_player: Vector2 = global_position.direction_to(Globals.player.global_position)
	velocity = move_speed * dir_to_player.rotated(randf_range(-PI / 6, PI / 6))


# MOVE WANDER STATE

func _on_wander_state_physics_processing(_delta: float) -> void:
	move_and_slide()
