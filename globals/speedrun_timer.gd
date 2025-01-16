extends Node


@onready var elapsed_time: float = 0.0
@onready var is_active: bool = false


func start() -> void:
	is_active = true


func stop() -> void:
	is_active = false


func reset() -> void:
	elapsed_time = 0.0


func _process(delta: float) -> void:
	if is_active:
		elapsed_time += delta
