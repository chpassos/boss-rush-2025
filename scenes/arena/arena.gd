@tool
class_name Arena
extends Node2D


@export var arena_size: Vector2 = Vector2(160, 90): set = _set_arena_size
@export var bg_offset: Vector2 = Vector2.ZERO: set = _set_bg_offset
@export var parallax_intensity: float = 0.5
@export_group("Nodes")
@export var top_boundary: StaticBody2D
@export var right_boundary: StaticBody2D
@export var bottom_boundary: StaticBody2D
@export var left_boundary: StaticBody2D
@export var bg_sprite: Sprite2D

@onready var bg_shader: ShaderMaterial = bg_sprite.material as ShaderMaterial
@onready var rect: Rect2 = Rect2(global_position - arena_size / 2, arena_size)


func _set_arena_size(a: Vector2) -> void:
	arena_size = a.abs()

	top_boundary.position.y = -arena_size.y / 2
	bottom_boundary.position.y = arena_size.y / 2
	left_boundary.position.x = -arena_size.x / 2
	right_boundary.position.x = arena_size.x / 2

	bg_sprite.scale = arena_size / 128


func _set_bg_offset(b: Vector2) -> void:
	bg_offset = b
	bg_shader.set_shader_parameter(&"offset", bg_offset)


func _ready() -> void:
	if not Engine.is_editor_hint():
		Globals.arena = self
		SignalBus.arena_ready.emit.call_deferred()


func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		return

	if not Globals.player:
		return

	var player_position: Vector2 = Globals.player.global_position - global_position
	var delta_offset: Vector2 = parallax_intensity * player_position
	bg_shader.set_shader_parameter(&"offset", bg_offset + delta_offset)


func has_point(point: Vector2) -> bool:
	return rect.has_point(point)
