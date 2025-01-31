extends Boss


@export var gravity_field: Area2D
@export var gravity_field_collision_shape: CollisionShape2D
@export var circle_attack_spawner: Spawner
@export var target_attack_spawner: Spawner
@export var homing_attack_spawner: Spawner

@onready var target_attack_count: int = 0
@onready var homing_attack_count: int = 0


func _ready() -> void:
	super._ready()

	gravity_field_collision_shape.disabled = true

	state_chart.set_expression_property(&"target_attack_count", target_attack_count)
	state_chart.set_expression_property(&"homing_attack_count", homing_attack_count)

	if not Globals.player:
		SignalBus.player_ready.connect(
			func():
				target_attack_spawner.trackedNode = Globals.player
				homing_attack_spawner.trackedNode = Globals.player
		)
	else:
		target_attack_spawner.trackedNode = Globals.player
		homing_attack_spawner.trackedNode = Globals.player


func _on_event_horizon_body_entered(body: Node2D) -> void:
	if body is CollectibleAsteroid:
		body.queue_free()
		heal(1)


# GRAVITY PULL ATTACK STATE

func _on_gravity_pull_state_entered() -> void:
	anim_player.play(&"gravity_pull")
	target_attack_count = 0
	state_chart.set_expression_property(&"target_attack_count", target_attack_count)
	homing_attack_count = 0
	state_chart.set_expression_property(&"homing_attack_count", homing_attack_count)
	gravity_field_collision_shape.disabled = false


func _on_gravity_pull_state_exited() -> void:
	gravity_field_collision_shape.disabled = true


# CIRCLE ATTACK STATE

func _on_circle_attack_state_entered() -> void:
	anim_player.play(&"circle_attack")
	for _i in range(20):
		circle_attack_spawner.set_manual_start(true)
		await get_tree().create_timer(0.25).timeout
	state_chart.send_event(&"attack_finished")


# TARGET ATTACK STATE

func _on_target_attack_state_entered() -> void:
	anim_player.play(&"target_attack")
	target_attack_count += 1
	state_chart.set_expression_property(&"target_attack_count", target_attack_count)
	for _i in range(10):
		target_attack_spawner.set_manual_start(true)
		await get_tree().create_timer(0.15).timeout
	state_chart.send_event(&"attack_finished")


# HOMING ATTACK STATE

func _on_homing_attack_state_entered() -> void:
	anim_player.play(&"homing_attack")
	target_attack_count = 0
	state_chart.set_expression_property(&"target_attack_count", target_attack_count)
	homing_attack_count += 1
	state_chart.set_expression_property(&"homing_attack_count", homing_attack_count)
	homing_attack_spawner.set_manual_start(true)
	state_chart.send_event(&"attack_finished")


# IDLE STATE

func _on_idle_state_entered() -> void:
	if anim_player.is_playing():
		if anim_player.current_animation == &"idle":
			return
		elif anim_player.current_animation == &"target_attack":
			anim_player.play(&"idle")
		else:
			anim_player.queue(&"idle")
