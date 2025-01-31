extends Boss


@export var move_speed: float = 100.0

@onready var is_furious: bool = false


func _on_small_star_died() -> void:
	is_furious = true
	move_speed *= 1.8
	anim_player.play(&"fury_transition")
	anim_player.queue(&"idle")


func _on_current_animation_changed(anim_name: StringName) -> void:
	if is_furious and anim_name == &"idle" or anim_name == &"attack" or anim_name == &"hit":
		anim_player.current_animation = anim_name + "_fury"


# MOVE IDLE STATE

func _on_idle_state_entered() -> void:
	var dir_to_player: Vector2 = global_position.direction_to(Globals.player.global_position)
	velocity = move_speed * dir_to_player.rotated(randf_range(-PI / 6, PI / 6))


# MOVE WANDER STATE

func _on_wander_state_physics_processing(_delta: float) -> void:
	move_and_slide()
