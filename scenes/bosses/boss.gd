class_name Boss
extends CharacterBody2D


@export var light_color: Color = Color.WHITE
@export_group("Nodes")
@export var sprite: Sprite2D
@export var anim_player: AnimationPlayer
@export var light: PointLight2D
@export var health_component: HealthComponent
@export var poise_component: PoiseComponent
@export var state_chart: StateChart


func _ready() -> void:
	light.color = light_color

	health_component.health_depleted.connect(_on_health_depleted)
	poise_component.poise_partially_restored.connect(_on_poise_partially_restored)
	poise_component.poise_fully_restored.connect(_on_poise_fully_restored)

	Globals.boss = self
	SignalBus.boss_ready.emit.call_deferred()
	SignalBus.camera_animation_finished.connect(_on_camera_animation_finished)


func take_damage(health_damage: int, poise_damage: float) -> void:
	health_component.take_damage(health_damage)
	poise_component.take_damage(poise_damage)
	SignalBus.boss_vitals_changed.emit()


func _on_health_depleted() -> void:
	queue_free()


func _on_poise_partially_restored() -> void:
	SignalBus.boss_vitals_changed.emit()


func _on_poise_fully_restored() -> void:
	SignalBus.boss_vitals_changed.emit()


func _on_camera_animation_finished(anim: StringName) -> void:
	if anim == &"intro":
		state_chart.send_event(&"battle_started")
