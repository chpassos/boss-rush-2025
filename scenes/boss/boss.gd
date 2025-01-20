class_name Boss
extends CharacterBody2D


@export var light_color: Color = Color.WHITE
@export_group("Nodes")
@export var sprite: Sprite2D
@export var light: PointLight2D
@export var health_component: HealthComponent
@export var poise_component: PoiseComponent


func _ready() -> void:
	light.color = light_color
	Globals.boss = self
	SignalBus.boss_ready.emit.call_deferred()


func take_damage(health_damage: int, poise_damage: float) -> void:
	health_component.take_damage(health_damage)
	poise_component.take_damage(poise_damage)
	SignalBus.boss_vitals_changed.emit()


func _on_health_component_health_reached_zero() -> void:
	queue_free()


func _on_poise_partially_restored() -> void:
	SignalBus.boss_vitals_changed.emit()


func _on_poise_fully_restored() -> void:
	SignalBus.boss_vitals_changed.emit()
