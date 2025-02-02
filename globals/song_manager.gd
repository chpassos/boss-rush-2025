extends AudioStreamPlayer2D


const FILLER_SONG: AudioStream = preload("res://assets/music/boss_rush_song5.wav")
const MAIN_MENU_SONG: AudioStream = preload("res://assets/music/boss_rush_song5.wav")
const RED_DWARF_BOSS_SONG: AudioStream = preload("res://assets/music/boss_rush_song3_v2.wav")
const BINARY_SYSTEM_BOSS_SONG: AudioStream = preload("res://assets/music/boss_rush_song1.wav")
const BINARY_SYSTEM_FURY_BOSS_SONG: AudioStream = preload("res://assets/music/boss_rush_phase2.wav")
const BLACK_HOLE_BOSS_SONG: AudioStream = preload("res://assets/music/boss_rush_song5.wav")


func _ready() -> void:
	pass


func play_song(song: AudioStream) -> void:
	stream = song
	play()


func play_filler_song() -> void:
	stream = FILLER_SONG
	play()


func play_main_menu_song() -> void:
	stream = MAIN_MENU_SONG
	play()


func play_red_dwarf_boss_song() -> void:
	stream = RED_DWARF_BOSS_SONG
	play()


func play_binary_system_boss_song() -> void:
	stream = BINARY_SYSTEM_BOSS_SONG
	play()


func play_binary_system_fury_boss_song() -> void:
	stream = BINARY_SYSTEM_FURY_BOSS_SONG
	play()


func play_black_hole_boss_song() -> void:
	stream = BLACK_HOLE_BOSS_SONG
	play()
