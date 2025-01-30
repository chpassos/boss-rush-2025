class_name CameraManager
extends PhantomCamera2D


@export var anim_player: AnimationPlayer


func _ready() -> void:
	SignalBus.arena_ready.connect(_on_arena_ready)
	SignalBus.player_defeated.connect(
		func():
			anim_player.play(&"defeat")
	)
	SignalBus.boss_defeated.connect(
		func():
			anim_player.play(&"outro")
	)


func _on_arena_ready() -> void:
	var zero: Vector2 = Globals.arena.global_position
	@warning_ignore("narrowing_conversion")
	limit_left = zero.x - Globals.arena.arena_size.x / 2
	@warning_ignore("narrowing_conversion")
	limit_top = zero.y - Globals.arena.arena_size.y / 2
	@warning_ignore("narrowing_conversion")
	limit_right = zero.x + Globals.arena.arena_size.x / 2
	@warning_ignore("narrowing_conversion")
	limit_bottom = zero.y + Globals.arena.arena_size.y / 2


func set_target_to_player() -> void:
	follow_target = Globals.player


func set_target_to_boss() -> void:
	follow_target = Globals.boss


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	SignalBus.camera_animation_finished.emit(anim_name)
