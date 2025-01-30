extends Control


func enable() -> void:
	get_tree().paused = true
	show()


func disable() -> void:
	get_tree().paused = false
	hide()


func _on_back_button_pressed() -> void:
	disable()


func _on_settings_button_pressed() -> void:
	pass # Replace with function body.


func _on_credits_button_pressed() -> void:
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	get_tree().quit()
