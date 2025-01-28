class_name HealthComponent
extends Node


signal health_depleted()

@export_range(0, 500, 1, "or_greater") var max_health: int = 100

@onready var current_health: int = max_health


func take_damage(amount: int) -> void:
	current_health = maxi(current_health - amount, 0)

	if not current_health:
		health_depleted.emit()


func heal(amount: int) -> void:
	current_health = mini(current_health + amount, max_health)
