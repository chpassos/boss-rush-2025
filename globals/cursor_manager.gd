extends Node


const CURSOR_DEFAULT: Texture2D = preload("res://assets/cursor/cursor.png")


func _ready() -> void:
	Input.set_custom_mouse_cursor(CURSOR_DEFAULT, Input.CURSOR_ARROW, 12 * Vector2.ONE)
