extends Control

@onready var start_level : PackedScene = preload("res://scenes/test.tscn")

func _on_start_button_pressed():
	get_tree().change_scene_to_packed(start_level)

func _on_quit_button_pressed():
	get_tree().quit()
