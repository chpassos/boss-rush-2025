extends Control


@export_file("*.tscn") var main_menu_scene_path: String


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file(main_menu_scene_path)
