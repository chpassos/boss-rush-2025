class_name LevelTransition
extends Control


@export var level_scenes: Dictionary


func _on_transition_timer_timeout() -> void:
	if Globals.current_boss in level_scenes:
		get_tree().change_scene_to_packed(level_scenes[Globals.current_boss])
	else:
		get_tree().quit()
