class_name OrbitingAsteroid
extends Sprite2D


@export var primary: Node2D
@export_range(0.0, 100.0, 5.0, "or_greater", "suffix:px") var orbiting_distance: float = 20.0
@export_range(0.0, TAU, 0.001, "or_greater", "suffix:rad/s") var orbiting_speed: float = PI
@export var clockwise: bool

@onready var angle: float = randf_range(-PI, PI)


func _process(delta: float) -> void:
	if clockwise:
		angle += delta * orbiting_speed
	else:
		angle -= delta * orbiting_speed

	angle = fmod(angle, TAU)

	var target_position: Vector2 = primary.global_position + orbiting_distance * Vector2.RIGHT.rotated(angle)

	var speed: float = (1 + log(global_position.distance_to(target_position)) / 2.5) * orbiting_speed * orbiting_distance
	global_position = global_position.move_toward(target_position, delta * speed)
