class_name MovementInputComponent
extends Node


@export var actor: CharacterBody2D
@export var max_speed: float = 200.0
@export var acceleration: float = 1500.0
@export var drag: float = 800.0


func _physics_process(delta: float) -> void:
	var input_dir: Vector2 = Input.get_vector(&"move_left", &"move_right", &"move_up", &"move_down")

	if not input_dir:
		if actor.velocity.length() > delta * drag:
			actor.velocity -= delta * drag * actor.velocity.normalized()
		else:
			actor.velocity = Vector2.ZERO

	else:
		actor.velocity += delta * acceleration * input_dir
		actor.velocity = actor.velocity.limit_length(max_speed)

	actor.move_and_slide()
