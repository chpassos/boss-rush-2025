class_name HealthComponent
extends Node


signal health_reached_zero()

@export var max_health: int = 5

@onready var current_health: int = max_health


func take_damage(amount: int):
	current_health = maxi(current_health - amount, 0)

	if not current_health:
		health_reached_zero.emit()
