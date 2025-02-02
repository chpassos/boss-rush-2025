extends Level


func _ready() -> void:
	super._ready()

	SongManager.play_binary_system_boss_song()


func _on_big_star_got_furious() -> void:
	SongManager.play_binary_system_fury_boss_song()
