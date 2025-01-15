class_name Player
extends CharacterBody2D


@export var max_speed: float = 200.0
@export var acceleration: float = 1500.0
@export var drag: float = 800.0
@export var orbiting_asteroid_scene: PackedScene
@export_group("Nodes")
@export var planet_shape: Sprite2D
@export var planet_map: Sprite2D

@onready var state_chart: StateChart = $StateChart as StateChart
@onready var rotation_input_queue: Array[StringName] = []
@onready var asteroids: Array[AsteroidData] = []


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"toggle_shoot_mode"):
		state_chart.send_event(&"pressed_shoot")
	elif event.is_action_released(&"toggle_shoot_mode"):
		state_chart.send_event(&"released_shoot")


func add_asteroid(asteroid_data: AsteroidData) -> void:
	asteroids.append(asteroid_data)

	var orbiting_asteroid: OrbitingAsteroid = orbiting_asteroid_scene.instantiate() as OrbitingAsteroid
	orbiting_asteroid.primary = self
	orbiting_asteroid.orbiting_distance = clampf(randfn(40.0, 10.0), 20.0, 60.0)
	orbiting_asteroid.orbiting_speed = randf_range(PI / 2, 2 * PI)
	orbiting_asteroid.modulate = asteroid_data.color
	orbiting_asteroid.global_position = global_position + orbiting_asteroid.orbiting_distance * Vector2.RIGHT
	orbiting_asteroid.top_level = true

	add_child(orbiting_asteroid)


# MOVE STATE

func _on_move_state_physics_processing(delta: float) -> void:
	var input_dir: Vector2 = Input.get_vector(&"move_left", &"move_right", &"move_up", &"move_down")

	# Set sprite direction
	if input_dir.x == 0 and input_dir.y == 0:  # idle
		planet_shape.region_rect.position.x = 0
		planet_map.position.x = -37
	elif input_dir.x == 0 and input_dir.y > 0:  # forward
		planet_shape.region_rect.position.x = 0
		planet_map.position.x = -37
	elif input_dir.x > 0 and input_dir.y > 0:  # forward-right
		planet_shape.region_rect.position.x = 38
		planet_map.position.x = -29
	elif input_dir.x > 0 and input_dir.y == 0:  # right
		planet_shape.region_rect.position.x = 76
		planet_map.position.x = -21
	elif input_dir.x > 0 and input_dir.y < 0:  # backward-right
		planet_shape.region_rect.position.x = 114
		planet_map.position.x = -13
	elif input_dir.x == 0 and input_dir.y < 0:  # backward
		planet_shape.region_rect.position.x = 152
		planet_map.position.x = -5
	elif input_dir.x < 0 and input_dir.y < 0:  # backward-left
		planet_shape.region_rect.position.x = 190
		planet_map.position.x = 3
	elif input_dir.x < 0 and input_dir.y == 0:  # left
		planet_shape.region_rect.position.x = 228
		planet_map.position.x = 11
	elif input_dir.x < 0 and input_dir.y > 0:  # forward-left
		planet_shape.region_rect.position.x = 266
		planet_map.position.x = 19

	if not input_dir:
		if velocity.length() > delta * drag:
			velocity -= delta * drag * velocity.normalized()
		else:
			velocity = Vector2.ZERO

	else:
		velocity += delta * acceleration * input_dir
		velocity = velocity.limit_length(max_speed)

	move_and_slide()


# SHOOT STATE

func _on_shoot_state_entered() -> void:
	rotation_input_queue = []


func _on_shoot_state_unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"move_up"):
		if not rotation_input_queue:
			rotation_input_queue = [&"move_up"]
		elif rotation_input_queue[-1] == &"move_up":
			pass
		elif (rotation_input_queue.size() > 1 and rotation_input_queue[-2] == &"move_down") \
		or (rotation_input_queue[-1] == &"move_right" or rotation_input_queue[-1] == &"move_left"):
			rotation_input_queue.append(&"move_up")
		else:
			rotation_input_queue = [&"move_up"]

	elif event.is_action_pressed(&"move_right"):
		if not rotation_input_queue:
			rotation_input_queue = [&"move_right"]
		elif rotation_input_queue[-1] == &"move_right":
			pass
		elif (rotation_input_queue.size() > 1 and rotation_input_queue[-2] == &"move_left") \
		or (rotation_input_queue[-1] == &"move_up" or rotation_input_queue[-1] == &"move_down"):
			rotation_input_queue.append(&"move_right")
		else:
			rotation_input_queue = [&"move_right"]

	elif event.is_action_pressed(&"move_down"):
		if not rotation_input_queue:
			rotation_input_queue = [&"move_down"]
		elif rotation_input_queue[-1] == &"move_down":
			pass
		elif (rotation_input_queue.size() > 1 and rotation_input_queue[-2] == &"move_up") \
		or (rotation_input_queue[-1] == &"move_right" or rotation_input_queue[-1] == &"move_left"):
			rotation_input_queue.append(&"move_down")
		else:
			rotation_input_queue = [&"move_down"]

	elif event.is_action_pressed(&"move_left"):
		if not rotation_input_queue:
			rotation_input_queue = [&"move_left"]
		elif rotation_input_queue[-1] == &"move_left":
			pass
		elif (rotation_input_queue.size() > 1 and rotation_input_queue[-2] == &"move_right") \
		or (rotation_input_queue[-1] == &"move_up" or rotation_input_queue[-1] == &"move_down"):
			rotation_input_queue.append(&"move_left")
		else:
			rotation_input_queue = [&"move_left"]

	if rotation_input_queue.size() == 4:
		print("SHOOT!")
		rotation_input_queue = []
