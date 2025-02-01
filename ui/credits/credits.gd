extends Control


func _ready() -> void:
	SongManager.play_filler_song()


func _on_back_button_pressed() -> void:
	hide()
