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
	SignalBus.player_defeated.connect(
		func():
			state_chart.send_event(&"player_defeated")
	)


func take_damage(health_damage: int, poise_damage: float) -> void:
	health_component.take_damage(health_damage)
	poise_component.take_damage(poise_damage)

	if health_component.current_health:
		anim_player.stop()
		anim_player.play(&"hit")
		anim_player.queue(&"idle")

	SignalBus.boss_vitals_changed.emit()


func heal(amount: int) -> void:
	health_component.heal(amount)
	SignalBus.boss_vitals_changed.emit()


func _on_health_depleted() -> void:
	state_chart.send_event(&"boss_defeated")
	SignalBus.boss_defeated.emit()


func _on_poise_partially_restored() -> void:
	SignalBus.boss_vitals_changed.emit()


func _on_poise_fully_restored() -> void:
	SignalBus.boss_vitals_changed.emit()


func _on_camera_animation_finished(anim: StringName) -> void:
	if anim == &"intro":
		state_chart.send_event(&"battle_started")


func _on_bullet_hit(result: Array, _bulletIndex: int, _spawner: Object) -> void:
	if result[0]["collider"] == Globals.player:
		Globals.player.take_damage(1)
