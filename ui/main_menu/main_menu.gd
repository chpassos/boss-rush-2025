extends Control


@export_file("*.tscn") var level_transition_scene_path: String
@export var credits: Control


func _ready() -> void:
	if not SaveManager.load_game():
		(%ContinueButton as TextureButton).disabled = true
		(%ContinueButton as TextureButton).focus_mode = Control.FOCUS_NONE


func _on_start_button_pressed() -> void:
	Globals.current_boss = 1
	SpeedrunTimer.elapsed_time = 0.0
	get_tree().change_scene_to_file(level_transition_scene_path)


func _on_continue_button_pressed() -> void:
	Globals.current_boss = SaveManager.saved_current_boss
	SpeedrunTimer.elapsed_time = SaveManager.saved_elapsed_time
	get_tree().change_scene_to_file(level_transition_scene_path)


func _on_settings_button_pressed() -> void:
	pass # Replace with function body.


func _on_credits_button_pressed() -> void:
	credits.show()


func _on_quit_button_pressed() -> void:
	get_tree().quit()
