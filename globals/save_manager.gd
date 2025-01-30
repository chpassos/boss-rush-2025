extends Node


const FILENAME: String = "info.save"

@onready var saved_current_boss: int = -1
@onready var saved_elapsed_time: float = -1.0


func save_game() -> void:
	var save_file: FileAccess = FileAccess.open("user://" + FILENAME, FileAccess.WRITE)
	save_file.store_8(Globals.current_boss)
	save_file.store_float(SpeedrunTimer.elapsed_time)


func load_game() -> bool:
	if not FileAccess.file_exists("user://" + FILENAME):
		return false

	var save_file: FileAccess = FileAccess.open("user://" + FILENAME, FileAccess.READ)

	saved_current_boss = save_file.get_8()

	if saved_current_boss > Globals.TOTAL_BOSSES:
		return false

	saved_elapsed_time = save_file.get_float()

	return true
