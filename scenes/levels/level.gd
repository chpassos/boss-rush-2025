class_name Level
extends Node2D


@export var boss_number: int = 0
@export var pause_menu: PauseMenu
@export_file("*.tscn") var next_scene_path: String


func _ready() -> void:
	SignalBus.boss_defeated.connect(_on_boss_defeated)
	SignalBus.camera_animation_finished.connect(_on_camera_animation_finished)


func _on_boss_defeated() -> void:
	Globals.current_boss = boss_number + 1
	SpeedrunTimer.stop()
	SaveManager.save_game()


func _on_camera_animation_finished(anim_name: StringName) -> void:
	if anim_name == &"intro":
		SpeedrunTimer.start()
	elif anim_name == &"outro":
		get_tree().change_scene_to_file(next_scene_path)
	elif anim_name == &"defeat":
		get_tree().quit()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"pause"):
		pause_menu.enable()
