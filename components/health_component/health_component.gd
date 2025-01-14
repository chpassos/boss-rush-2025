@icon("heart.svg")
class_name HealthComponent
extends Node


signal health_reached_zero()

@export_range(0, 10, 1, "or_greater") var max_health: int = 5:
	set(mh):
		set_max_health(mh, false)

@onready var health: int = max_health: set = _set_health


func _set_health(h: int) -> void:
	health = clampi(h, 0, max_health)

	if not health:
		health_reached_zero.emit()


func set_max_health(mh: int, heal_diff: bool = true) -> void:
	assert(mh > 0, "HealthComponent.max_health must be a positive value.")

	if mh == max_health:
		return

	if mh > max_health:
		var diff: int = mh - max_health
		max_health = mh

		if heal_diff:
			health += diff

	else:
		max_health = mh
		health = health


func take_damage(value: int) -> void:
	assert(value >= 0, "HealthComponent.take_damage expects a non-negative value.")
	health -= value


func heal(value: int, extra_to_shield: bool = false) -> void:
	assert(value >= 0, "HealthComponent.take_damage expects a non-negative value.")
	health += value
