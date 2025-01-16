extends Node

# COPIEI O SCRIPT DE OUTRO JOGO
# OS NOMES E FUNÇOES NAO TEM NADA A VER
# EH SOH PRA REFERENCIA


const CURSOR_DEFAULT: Texture2D = preload("res://assets/pixel.png")
const CURSOR_GRAB: Texture2D = preload("res://assets/pixel.png")


func _ready() -> void:
	Input.set_custom_mouse_cursor(CURSOR_DEFAULT, Input.CURSOR_ARROW, Vector2(18, 18))

	SignalBus.player_grabbed_item.connect(_on_player_grabbed_item)
	SignalBus.player_released_item.connect(_on_player_released_item)


func _on_player_grabbed_item() -> void:
	Input.set_custom_mouse_cursor(CURSOR_GRAB, Input.CURSOR_ARROW, Vector2(18, 18))


func _on_player_released_item() -> void:
	Input.set_custom_mouse_cursor(CURSOR_DEFAULT, Input.CURSOR_ARROW, Vector2(18, 18))
