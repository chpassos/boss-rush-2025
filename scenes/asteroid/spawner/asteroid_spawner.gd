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


func _draw() -> void:
	draw_circle(Vector2.ZERO, spawn_radius, Color.WHITE, false)  # TODO: só pra debuggar


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

	if r < heal_asteroid_weight / total_weight:
		spawn_heal_asteroid()
	elif r < (heal_asteroid_weight + clockwise_asteroid_weight) / total_weight:
		spawn_clockwise_asteroid()
	else:
		spawn_counterclockwise_asteroid()


func spawn_heal_asteroid() -> void:
	var asteroid: HealAsteroid = Globals.HEAL_ASTEROID_SCENE.instantiate() as HealAsteroid
	#asteroid.top_level = true
	#asteroid.global_position = global_position + spawn_radius * Utils.random_point_in_circle()
	asteroid.position = spawn_radius * Utils.random_point_in_circle()
	add_child(asteroid)


func spawn_clockwise_asteroid() -> void:
	var asteroid: CollectibleAsteroid = Globals.COLLECTIBLE_ASTEROID_SCENE.instantiate() as CollectibleAsteroid
	#asteroid.top_level = true
	#asteroid.global_position = global_position + spawn_radius * Utils.random_point_in_circle()
	asteroid.position = spawn_radius * Utils.random_point_in_circle()
	asteroid.clockwise = true
	add_child(asteroid)


func spawn_counterclockwise_asteroid() -> void:
	var asteroid: CollectibleAsteroid = Globals.COLLECTIBLE_ASTEROID_SCENE.instantiate() as CollectibleAsteroid
	#asteroid.top_level = true
	#asteroid.global_position = global_position + spawn_radius * Utils.random_point_in_circle()
	asteroid.position = spawn_radius * Utils.random_point_in_circle()
	asteroid.clockwise = false
	add_child(asteroid)


func start_timer() -> void:
	spawn_timer.start(randf_range(min_wait_time, max_wait_time))


func _on_spawn_timer_timeout() -> void:
	spawn_asteroid()
	start_timer()
