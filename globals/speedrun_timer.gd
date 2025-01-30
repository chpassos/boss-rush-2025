extends Node


@onready var elapsed_time: float = 0.0
@onready var is_active: bool = false


func _ready() -> void:
	SignalBus.camera_animation_finished.connect(
		func(anim_name: StringName):
			if anim_name == &"intro":
				start()
	)
	SignalBus.boss_defeated.connect(stop)


func start() -> void:
	is_active = true


func stop() -> void:
	is_active = false


func reset() -> void:
	elapsed_time = 0.0


func _process(delta: float) -> void:
	if is_active:
		elapsed_time += delta
