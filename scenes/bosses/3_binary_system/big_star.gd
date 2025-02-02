extends Boss


signal got_furious()

@export var move_speed: float = 100.0
@export_group("Nodes")
@export var move_recalculate_timer: Timer
@export var circle_attack_spawner: Spawner
@export var target_attack_spawner: Spawner

@onready var is_furious: bool = false


func _ready() -> void:
	super._ready()

	state_chart.set_expression_property(&"is_furious", is_furious)

	if not Globals.player:
		SignalBus.player_ready.connect(
			func():
				target_attack_spawner.trackedNode = Globals.player
		)
	else:
		target_attack_spawner.trackedNode = Globals.player


func _on_small_star_died() -> void:
	is_furious = true
	got_furious.emit()
	state_chart.set_expression_property(&"is_furious", is_furious)
	move_speed *= 1.5
	anim_player.play(&"fury_transition")
	anim_player.queue(&"idle")


func _on_current_animation_changed(anim_name: StringName) -> void:
	if is_furious and anim_name == &"idle" or anim_name == &"attack" or anim_name == &"hit":
		anim_player.current_animation = anim_name + "_fury"


# MOVE STATE

func _on_move_state_entered() -> void:
	var dir_to_player: Vector2 = global_position.direction_to(Globals.player.global_position)
	velocity = move_speed * dir_to_player.rotated(randf_range(-PI / 8, PI / 8))
	move_recalculate_timer.start()


func _on_move_state_physics_processing(_delta: float) -> void:
	move_and_slide()


func _on_recalculate_timer_timeout() -> void:
	var dir_to_player: Vector2 = global_position.direction_to(Globals.player.global_position)
	velocity = move_speed * dir_to_player.rotated(randf_range(-PI / 8, PI / 8))


# TARGET ATTACK STATE

func _on_target_attack_state_entered() -> void:
	for _i in range(5):
		target_attack_spawner.offsetTowardPlayer = randf_range(-10, 10)
		target_attack_spawner.set_manual_start(true)
		await get_tree().create_timer(0.15).timeout
	state_chart.send_event(&"attack_finished")


# CIRCLE ATTACK STATE

func _on_circle_attack_state_entered() -> void:
	for _i in range(6):
		circle_attack_spawner.set_manual_start(true)
		await get_tree().create_timer(0.2).timeout
	state_chart.send_event(&"attack_finished")


# DEAD STATE

func _on_dead_state_entered() -> void:
	anim_player.play(&"death")
