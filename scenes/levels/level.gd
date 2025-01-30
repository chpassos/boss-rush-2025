class_name Level
extends Node2D


@export var pause_menu: PauseMenu


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"pause"):
		pause_menu.enable()
