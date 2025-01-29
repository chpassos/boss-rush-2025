extends Control


func _ready() -> void:
	(%ContinueButton as TextureButton).disabled = not SaveManager.load_game()
	(%ContinueButton as TextureButton).focus_mode = Control.FOCUS_NONE


func _on_start_button_pressed() -> void:
	pass # Replace with function body.


func _on_continue_button_pressed() -> void:
	pass # Replace with function body.


func _on_settings_button_pressed() -> void:
	pass # Replace with function body.


func _on_credits_button_pressed() -> void:
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	pass # Replace with function body.
