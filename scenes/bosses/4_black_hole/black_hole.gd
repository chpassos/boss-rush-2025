extends Boss


@export var gravity_field: Area2D
@export var gravity_field_collision_shape: CollisionShape2D
@export var circle_attack_spawner: Spawner
@export var target_attack_spawner: Spawner


func _ready() -> void:
	super._ready()

	if not Globals.player:
		SignalBus.player_ready.connect(
			func():
				target_attack_spawner.trackedNode = Globals.player
		)
	else:
		target_attack_spawner.trackedNode = Globals.player


func _on_event_horizon_body_entered(body: Node2D) -> void:
	if body is CollectibleAsteroid:
		body.queue_free()
		heal(1)


# GRAVITY PULL ATTACK STATE

func _on_gravity_pull_state_entered() -> void:
	gravity_field_collision_shape.disabled = false


func _on_gravity_pull_state_exited() -> void:
	gravity_field_collision_shape.disabled = true


# CIRCLE ATTACK STATE

func _on_circle_attack_state_entered() -> void:
	for _i in range(20):
		circle_attack_spawner.set_manual_start(true)
		await get_tree().create_timer(0.25).timeout


# TARGET ATTACK STATE

func _on_target_attack_state_entered() -> void:
	for _i in range(10):
		target_attack_spawner.set_manual_start(true)
		await get_tree().create_timer(0.15).timeout
