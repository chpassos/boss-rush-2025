class_name Boss
extends CharacterBody2D


@export var light_color: Color = Color.WHITE
@export_group("Nodes")
@export var sprite: Sprite2D
@export var light: PointLight2D
@export var health_component: HealthComponent


func _ready() -> void:
	sprite.modulate = light_color
	light.color = light_color


func take_damage(value: int) -> void:
	health_component.take_damage(value)


func _on_health_component_health_reached_zero() -> void:
	queue_free()
