class_name PoiseComponent
extends Node


signal poise_reached_zero()

@export_range(0.0, 100.0, 5.0, "or_greater") var max_poise: float = 10.0
@export_range(0.0, 2.0, 0.05, "or_greater", "suffix:/s") var regen: float = 0.1
@export_range(0.0, 10.0, 0.5, "or_greater", "suffix:s") var regen_delay: float = 2.5

@onready var current_poise: float = max_poise
@onready var regen_timer: Timer


func _ready() -> void:
	regen_timer = Timer.new()
	add_child(regen_timer)


func take_damage(amount: float):
	current_poise = maxf(current_poise - amount, 0)

	regen_timer.start(regen_delay)

	if not current_poise:
		poise_reached_zero.emit()


func _process(delta: float) -> void:
	if regen_timer.is_stopped() and current_poise < max_poise:
		print("healing")
		current_poise = minf(current_poise + regen * delta, max_poise)
