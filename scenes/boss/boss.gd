class_name Boss
extends CharacterBody2D


@export var light_color: Color = Color.WHITE
@export_group("Movement Stats")
@export_range(0.0, 100.0, 5.0, "or_greater", "suffix:px/s") var wander_speed: float = 50.0
@export_range(0.0, 200.0, 5.0, "or_greater", "suffix:px/s") var chase_speed: float = 120.0
@export_group("Nodes")
@export var sprite: Sprite2D
@export var light: PointLight2D
@export var health_component: HealthComponent
@export var poise_component: PoiseComponent
@export var state_chart: StateChart
@export var cone_attack_spawner: Spawner
@export var circle_attack_spawner: Spawner

@onready var wander_count: int = 0


func _ready() -> void:
	light.color = light_color
	state_chart.set_expression_property(&"wander_count", wander_count)

	Globals.boss = self
	SignalBus.boss_ready.emit.call_deferred()
	SignalBus.camera_animation_finished.connect(_on_camera_animation_finished)

	if not Globals.player:
		SignalBus.player_ready.connect(
			func():
				cone_attack_spawner.trackedNode = Globals.player
		)
	else:
		cone_attack_spawner.trackedNode = Globals.player


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


# MOVE STATE

func _on_move_state_exited() -> void:
	velocity = Vector2.ZERO


func _on_move_state_physics_processing(_delta: float) -> void:
	move_and_slide()


# WANDER STATE

func _on_wander_state_entered() -> void:
	wander_count += 1
	state_chart.set_expression_property(&"wander_count", wander_count)
	velocity = wander_speed * Vector2.RIGHT.rotated(TAU * randf())


# CHASE STATE

func _on_chase_state_entered() -> void:
	wander_count = 0
	state_chart.set_expression_property(&"wander_count", wander_count)

	if not Globals.player:
		return

	velocity = chase_speed * global_position.direction_to(Globals.player.global_position)


# CONE ATTACK STATE

func _on_cone_attack_state_entered() -> void:
	for _i in range(4):
		cone_attack_spawner.set_manual_start(true)
		await get_tree().create_timer(0.15).timeout


# CIRCLE ATTACK STATE

func _on_circle_attack_state_entered() -> void:
	circle_attack_spawner.set_manual_start(true)
