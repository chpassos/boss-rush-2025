extends Control


@export_file("*.tscn") var credits_scene_path: String


func _ready() -> void:
	if not SaveManager.load_game():
		(%ContinueButton as TextureButton).disabled = true
		(%ContinueButton as TextureButton).focus_mode = Control.FOCUS_NONE


func _on_start_button_pressed() -> void:
	pass # Replace with function body.


func _on_continue_button_pressed() -> void:
	pass # Replace with function body.


func _on_settings_button_pressed() -> void:
	pass # Replace with function body.


func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_file(credits_scene_path)


func _on_quit_button_pressed() -> void:
	get_tree().quit()
