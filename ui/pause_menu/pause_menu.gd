class_name PauseMenu
extends Control


@export_file("*.tscn") var main_menu_scene_path: String
@export var credits: Control


func enable() -> void:
	get_tree().paused = true
	show()


func disable() -> void:
	get_tree().paused = false
	hide()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"pause"):
		disable()


func _on_back_button_pressed() -> void:
	disable()


func _on_settings_button_pressed() -> void:
	pass # Replace with function body.


func _on_credits_button_pressed() -> void:
	credits.show()


func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file(main_menu_scene_path)
