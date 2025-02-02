extends Node2D


@export var spawner: Marker2D
@export var repeat_label: RichTextLabel
@export var exit_label: RichTextLabel
@export var exit_asteroid: HealAsteroid
@export_file("*.tscn") var main_menu_scene_path: String

@onready var shot_count: int = 0


func _ready() -> void:
	repeat_label.hide()
	exit_label.hide()
	exit_asteroid.hide()
	exit_asteroid.process_mode = Node.PROCESS_MODE_DISABLED

	spawn_asteroid()

	SongManager.play_filler_song()


func spawn_asteroid() -> void:
	var asteroid: CollectibleAsteroid = Globals.COLLECTIBLE_ASTEROID_SCENE.instantiate() as CollectibleAsteroid
	asteroid.global_position = spawner.global_position
	asteroid.clockwise = true
	asteroid.freeze = true
	add_child(asteroid)


func _on_player_shot_asteroid(_clockwise: bool) -> void:
	shot_count += 1
	spawn_asteroid()

	if shot_count == 1:
		repeat_label.show()

	elif shot_count == 2:
		repeat_label.hide()
		exit_label.show()
		exit_asteroid.show()
		exit_asteroid.process_mode = Node.PROCESS_MODE_INHERIT


func _on_exit_asteroid_collected() -> void:
	get_tree().change_scene_to_file(main_menu_scene_path)
