class_name Player
extends CharacterBody2D


@export var max_speed: float = 200.0
@export var acceleration: float = 1500.0
@export var drag: float = 800.0
@export_group("Nodes")
@export var sprite: Sprite2D
@export var anim_player: AnimationPlayer
@export var aim_line: Line2D
@export var ammo_display: AmmoDisplay
@export var health_component: HealthComponent
@export var state_chart: StateChart

@onready var rotation_input_queue: Array[StringName] = []
@onready var clockwise_asteroid_queue: Array[OrbitingAsteroid] = []
@onready var counterclockwise_asteroid_queue: Array[OrbitingAsteroid] = []
@onready var aim_line_default_opacity: float = aim_line.modulate.a


func _ready() -> void:
	Globals.player = self
	SignalBus.player_ready.emit.call_deferred()

	ammo_display.clockwise_ammo_counter.text = "0"
	ammo_display.counterclockwise_ammo_counter.text = "0"


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"toggle_shoot_mode"):
		state_chart.send_event(&"pressed_shoot")
	elif event.is_action_released(&"toggle_shoot_mode"):
		state_chart.send_event(&"released_shoot")


func _process(_delta: float) -> void:
	var mouse_position: Vector2 = get_global_mouse_position()
	var angle: float = global_position.angle_to_point(mouse_position)
	aim_line.rotation = angle


func _on_collision_detection_body_entered(_body: Boss) -> void:
	take_damage(1)


func _on_health_depleted() -> void:
	state_chart.send_event(&"player_died")


func take_damage(amount: int) -> void:
	if anim_player.is_playing() and anim_player.current_animation == &"hit":
		return

	anim_player.play(&"hit")
	health_component.take_damage(amount)
	SignalBus.player_vitals_changed.emit()


func heal(amount: int) -> void:
	health_component.heal(amount)
	SignalBus.player_vitals_changed.emit()


func add_asteroid_to_queue(clockwise: bool) -> void:
	var asteroid_data: AsteroidData = Globals.CLOCKWISE_ASTEROID_DATA if clockwise else Globals.COUNTERCLOCKWISE_ASTEROID_DATA

	var orbiting_asteroid: OrbitingAsteroid = Globals.ORBITING_ASTEROID_SCENE.instantiate() as OrbitingAsteroid
	orbiting_asteroid.primary = self
	orbiting_asteroid.orbiting_distance = clampf(randfn(40.0, 10.0), 20.0, 60.0)
	orbiting_asteroid.orbiting_speed = randf_range(PI / 2, 2 * PI)
	orbiting_asteroid.clockwise = asteroid_data.clockwise
	orbiting_asteroid.modulate = asteroid_data.color
	orbiting_asteroid.global_position = global_position + orbiting_asteroid.orbiting_distance * Vector2.RIGHT
	orbiting_asteroid.top_level = true

	add_child(orbiting_asteroid)

	if clockwise:
		clockwise_asteroid_queue.append(orbiting_asteroid)
		ammo_display.clockwise_ammo_counter.text = str(clockwise_asteroid_queue.size())
	else:
		counterclockwise_asteroid_queue.append(orbiting_asteroid)
		ammo_display.counterclockwise_ammo_counter.text = str(counterclockwise_asteroid_queue.size())


func shoot_asteroid_from_queue(clockwise: bool, direction: Vector2) -> void:
	if clockwise:
		if not clockwise_asteroid_queue:
			return

		var orbiting_asteroid: OrbitingAsteroid = clockwise_asteroid_queue.pop_front()
		orbiting_asteroid.queue_free()
		ammo_display.clockwise_ammo_counter.text = str(clockwise_asteroid_queue.size())
		ProjectileManager.spawn_projectile(global_position, true, direction)

	else:
		if not counterclockwise_asteroid_queue:
			return

		var orbiting_asteroid: OrbitingAsteroid = counterclockwise_asteroid_queue.pop_front()
		orbiting_asteroid.queue_free()
		ammo_display.counterclockwise_ammo_counter.text = str(counterclockwise_asteroid_queue.size())
		ProjectileManager.spawn_projectile(global_position, false, direction)


# MOVE STATE

func _on_move_state_physics_processing(delta: float) -> void:
	var input_dir: Vector2 = Input.get_vector(&"move_left", &"move_right", &"move_up", &"move_down")

	# Set sprite direction
	if not anim_player.is_playing():
		if input_dir.x == 0 and input_dir.y == 0:  # idle
			sprite.region_rect.position = Vector2(0, 0)
		elif input_dir.x == 0 and input_dir.y > 0:  # forward
			sprite.region_rect.position = Vector2(0, 0)
		elif input_dir.x > 0 and input_dir.y > 0:  # forward-right
			sprite.region_rect.position = Vector2(38, 0)
		elif input_dir.x > 0 and input_dir.y == 0:  # right
			sprite.region_rect.position = Vector2(76, 0)
		elif input_dir.x > 0 and input_dir.y < 0:  # backward-right
			sprite.region_rect.position = Vector2(114, 0)
		elif input_dir.x == 0 and input_dir.y < 0:  # backward
			sprite.region_rect.position = Vector2(152, 0)
		elif input_dir.x < 0 and input_dir.y < 0:  # backward-left
			sprite.region_rect.position = Vector2(190, 0)
		elif input_dir.x < 0 and input_dir.y == 0:  # left
			sprite.region_rect.position = Vector2(228, 0)
		elif input_dir.x < 0 and input_dir.y > 0:  # forward-left
			sprite.region_rect.position = Vector2(266, 0)

	var gravity: Vector2 = get_gravity()

	if not gravity:
		if not input_dir:
			if velocity.length() > delta * drag:
				velocity -= delta * drag * velocity.normalized()
			else:
				velocity = Vector2.ZERO

		else:
			velocity += delta * acceleration * input_dir

	else:
		gravity = 0.8 * acceleration * gravity.normalized()
		velocity += delta * (acceleration * input_dir + gravity)

	velocity = velocity.limit_length(max_speed)
	move_and_slide()


# SHOOT STATE

func _on_shoot_state_entered() -> void:
	rotation_input_queue = []
	aim_line.modulate.a = 1.0
	ammo_display.show()


func _on_shoot_state_exited() -> void:
	aim_line.modulate.a = aim_line_default_opacity
	anim_player.stop()
	ammo_display.hide()


func _on_shoot_state_unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"spin_clockwise_1"):
		if not rotation_input_queue:
			rotation_input_queue = [&"spin_clockwise_1"]
		elif rotation_input_queue[-1] == &"spin_clockwise_1":
			pass
		elif rotation_input_queue[-1] == &"spin_clockwise_2":
			rotation_input_queue.append(&"spin_clockwise_1")
		else:
			rotation_input_queue = [&"spin_clockwise_1"]

		anim_player.play_backwards(&"rotation")

	elif event.is_action_pressed(&"spin_clockwise_2"):
		if not rotation_input_queue:
			rotation_input_queue = [&"spin_clockwise_2"]
		elif rotation_input_queue[-1] == &"spin_clockwise_2":
			pass
		elif rotation_input_queue[-1] == &"spin_clockwise_1":
			rotation_input_queue.append(&"spin_clockwise_2")
		else:
			rotation_input_queue = [&"spin_clockwise_2"]

		anim_player.play_backwards(&"rotation")

	elif event.is_action_pressed(&"spin_counterclockwise_1"):
		if not rotation_input_queue:
			rotation_input_queue = [&"spin_counterclockwise_1"]
		elif rotation_input_queue[-1] == &"spin_counterclockwise_1":
			pass
		elif rotation_input_queue[-1] == &"spin_counterclockwise_2":
			rotation_input_queue.append(&"spin_counterclockwise_1")
		else:
			rotation_input_queue = [&"spin_counterclockwise_1"]

		anim_player.play(&"rotation")

	elif event.is_action_pressed(&"spin_counterclockwise_2"):
		if not rotation_input_queue:
			rotation_input_queue = [&"spin_counterclockwise_2"]
		elif rotation_input_queue[-1] == &"spin_counterclockwise_2":
			pass
		elif rotation_input_queue[-1] == &"spin_counterclockwise_1":
			rotation_input_queue.append(&"spin_counterclockwise_2")
		else:
			rotation_input_queue = [&"spin_counterclockwise_2"]

		anim_player.play(&"rotation")

	if rotation_input_queue.size() == 4:
		var mouse_position: Vector2 = get_global_mouse_position()
		var shoot_dir: Vector2 = global_position.direction_to(mouse_position)

		if rotation_input_queue[0] == &"spin_clockwise_1" or rotation_input_queue[0] == &"spin_clockwise_2":
			shoot_asteroid_from_queue(true, shoot_dir)
			#print("SHOOT CLOCKWISE!")
		else:
			shoot_asteroid_from_queue(false, shoot_dir)
			#print("SHOOT COUNTERCLOCKWISE!")

		rotation_input_queue = []


func _on_shoot_state_processing(_delta: float) -> void:
	if anim_player.is_playing() \
	and (anim_player.current_animation == &"rotation" or anim_player.current_animation == &"hit"):
		return

	var dir_to_mouse: Vector2 = global_position.direction_to(get_global_mouse_position())
	var dot: float = Vector2.RIGHT.dot(dir_to_mouse)

	if dot > 0.5:
		anim_player.play(&"aim_right")
	elif dot > -0.5:
		anim_player.play(&"aim_center")
	else:
		anim_player.play(&"aim_left")


# DEAD STATE

func _on_dead_state_entered() -> void:
	anim_player.queue(&"death")
	SpeedrunTimer.stop()
	SignalBus.player_defeated.emit()
