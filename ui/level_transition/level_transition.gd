class_name LevelTransition
extends Control


@export var level_scenes: Dictionary


func _ready() -> void:
	SaveManager.save_game()


func _on_transition_timer_timeout() -> void:
	get_tree().change_scene_to_packed(level_scenes[Globals.current_boss])
