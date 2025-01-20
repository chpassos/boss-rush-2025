@tool
extends Node2D


@export var arena_size: Vector2 = Vector2(160, 90): set = _set_arena_size
@export_group("Nodes")
@export var top_boundary: StaticBody2D
@export var right_boundary: StaticBody2D
@export var bottom_boundary: StaticBody2D
@export var left_boundary: StaticBody2D
@export var bg_sprite: Sprite2D


func _set_arena_size(a: Vector2) -> void:
	arena_size = a.abs()

	top_boundary.position.y = -arena_size.y / 2
	bottom_boundary.position.y = arena_size.y / 2
	left_boundary.position.x = -arena_size.x / 2
	right_boundary.position.x = arena_size.x / 2

	bg_sprite.scale = arena_size / 128
