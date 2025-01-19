class_name Boss
extends CharacterBody2D


@export var light_color: Color = Color.WHITE
@export_group("Nodes")
@export var sprite: Sprite2D
@export var light: PointLight2D
@export var health_component: HealthComponent
@export var poise_component: PoiseComponent


func _ready() -> void:
	sprite.modulate = light_color
	light.color = light_color


func take_damage(health_damage: int, poise_damage: float) -> void:
	health_component.take_damage(health_damage)
	poise_component.take_damage(poise_damage)


func _on_health_component_health_reached_zero() -> void:
	queue_free()
