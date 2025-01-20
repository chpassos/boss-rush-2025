extends Node


const FILENAME: String = "info.save"


func save_game() -> void:
	var save_file: FileAccess = FileAccess.open("user://" + FILENAME, FileAccess.WRITE)
	save_file.store_8(Globals.current_boss)


func load_game() -> int:
	if not FileAccess.file_exists("user://" + FILENAME):
		return -1

	var save_file: FileAccess = FileAccess.open("user://" + FILENAME, FileAccess.READ)
	return save_file.get_8()
