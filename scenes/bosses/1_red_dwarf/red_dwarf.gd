extends Boss


@export_range(0.0, 100.0, 5.0, "or_greater", "suffix:px/s") var wander_speed: float = 50.0
@export_range(0.0, 200.0, 5.0, "or_greater", "suffix:px/s") var chase_speed: float = 120.0
@export var cone_attack_spawner: Spawner
@export var circle_attack_spawner: Spawner

@onready var wander_count: int = 0


func _ready() -> void:
	super._ready()

	state_chart.set_expression_property(&"wander_count", wander_count)

	if not Globals.player:
		SignalBus.player_ready.connect(
			func():
				cone_attack_spawner.trackedNode = Globals.player
		)
	else:
		cone_attack_spawner.trackedNode = Globals.player


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
