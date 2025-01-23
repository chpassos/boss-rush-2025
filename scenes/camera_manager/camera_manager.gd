class_name CameraManager
extends PhantomCamera2D


func _ready() -> void:
	SignalBus.arena_ready.connect(_on_arena_ready)


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
