extends AudioStreamPlayer2D


const FILLER_SONG: AudioStream = preload("res://assets/music/boss_rush_song5.wav")
const MAIN_MENU_SONG: AudioStream = preload("res://assets/music/boss_rush_song5.wav")
const RED_DWARF_BOSS_SONG: AudioStream = preload("res://assets/music/boss_rush_song3_v2.wav")
const BINARY_SYSTEM_BOSS_SONG: AudioStream = preload("res://assets/music/boss_rush_song1.wav")
const BINARY_SYSTEM_FURY_BOSS_SONG: AudioStream = preload("res://assets/music/boss_rush_phase2.wav")
const BLACK_HOLE_BOSS_SONG: AudioStream = preload("res://assets/music/boss_rush_final_boss_without_intro.wav")


func _ready() -> void:
	pass


func play_song(song: AudioStream, from_position: float = 0.0) -> void:
	stream = song
	play(from_position)


func play_filler_song(from_position: float = 0.0) -> void:
	stream = FILLER_SONG
	play(from_position)


func play_main_menu_song(from_position: float = 0.0) -> void:
	stream = MAIN_MENU_SONG
	play(from_position)


func play_red_dwarf_boss_song(from_position: float = 0.0) -> void:
	stream = RED_DWARF_BOSS_SONG
	play(from_position)


func play_binary_system_boss_song(from_position: float = 0.0) -> void:
	stream = BINARY_SYSTEM_BOSS_SONG
	play(from_position)


func play_binary_system_fury_boss_song(from_position: float = 0.0) -> void:
	stream = BINARY_SYSTEM_FURY_BOSS_SONG
	play(from_position)


func play_black_hole_boss_song() -> void:
	stream = BLACK_HOLE_BOSS_SONG
	play()
