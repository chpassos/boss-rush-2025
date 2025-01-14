class_name Player
extends CharacterBody2D


@export var actor: CharacterBody2D
@export var max_speed: float = 200.0
@export var acceleration: float = 1500.0
@export var drag: float = 800.0

@onready var state_chart: StateChart = $StateChart as StateChart


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"toggle_shoot_mode"):
		state_chart.send_event(&"pressed_shoot")
	elif event.is_action_released(&"toggle_shoot_mode"):
		state_chart.send_event(&"released_shoot")


func _on_move_state_physics_processing(delta: float) -> void:
	var input_dir: Vector2 = Input.get_vector(&"move_left", &"move_right", &"move_up", &"move_down")

	if not input_dir:
		if velocity.length() > delta * drag:
			velocity -= delta * drag * velocity.normalized()
		else:
			velocity = Vector2.ZERO

	else:
		velocity += delta * acceleration * input_dir
		velocity = velocity.limit_length(max_speed)

	move_and_slide()
