extends Node2D


@export var spawn_on_ready: bool = false
@export_range(0.0, 500.0, 10.0, "or_greater", "suffix:px") var spawn_radius: float = 200.0
@export_range(0.0, 30.0, 0.5, "or_greater", "suffix:s") var min_wait_time: float = 1.0
@export_range(0.0, 30.0, 0.5, "or_greater", "suffix:s") var max_wait_time: float = 2.5
@export_range(0.0, 10.0, 1.0, "or_greater", "suffix:px") var heal_asteroid_weight: float = 1.0
@export_range(0.0, 10.0, 1.0, "or_greater", "suffix:px") var clockwise_asteroid_weight: float = 1.0
@export_range(0.0, 10.0, 1.0, "or_greater", "suffix:px") var counterclockwise_asteroid_weight: float = 1.0
@export var spawn_timer: Timer

@onready var total_weight: float = heal_asteroid_weight + clockwise_asteroid_weight + counterclockwise_asteroid_weight


func _ready() -> void:
	assert(spawn_radius > 0)
	assert(min_wait_time > 0)
	assert(max_wait_time >= min_wait_time)
	assert(total_weight > 0)

	if spawn_on_ready:
		spawn_asteroid()
	start_timer()


func spawn_asteroid() -> void:
	var r: float = randf()
	var gpos: Vector2 = global_position + spawn_radius * Utils.random_point_in_circle()

	if r < heal_asteroid_weight / total_weight:
		CollectiblesManager.spawn_heal_asteroid(gpos)
	elif r < (heal_asteroid_weight + clockwise_asteroid_weight) / total_weight:
		CollectiblesManager.spawn_clockwise_asteroid(gpos)
	else:
		CollectiblesManager.spawn_counterclockwise_asteroid(gpos)


func start_timer() -> void:
	spawn_timer.start(randf_range(min_wait_time, max_wait_time))


func _on_spawn_timer_timeout() -> void:
	spawn_asteroid()
	start_timer()
