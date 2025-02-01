extends Control


@export_file("*.tscn") var main_menu_scene_path: String


func _ready() -> void:
	(%Time as Label).text = "Your time was " + Utils.time_to_text(SpeedrunTimer.elapsed_time)


func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file(main_menu_scene_path)
