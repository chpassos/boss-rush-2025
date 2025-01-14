class_name PlayerRotationDetectionComponent
extends Node


@export var actor: CharacterBody2D

@onready var player: Player = get_tree().get_first_node_in_group(&"player") as Player
@onready var zero: float = actor.global_position.angle_to_point(player.global_position)
@onready var quadrants_visited: Array[int] = []


func rad_to_quadrant(rad: float) -> int:
	if -PI / 2 < rad and rad <= 0:
		return 1
	elif -PI < rad and rad <= -PI / 2:
		return 2
	elif PI / 2 < rad and rad <= PI:
		return 3
	elif 0 < rad and rad <= PI / 2:
		return 4
	else:
		return 0


func _ready() -> void:
	quadrants_visited.append(rad_to_quadrant(zero))


func _physics_process(delta: float) -> void:
	var rad: float = actor.global_position.angle_to_point(player.global_position)
	var quadrant: int = rad_to_quadrant(rad)

	if absf(rad - zero) <= 0.1 and quadrants_visited.size() >= 4:
		quadrants_visited = [quadrant]

	if quadrant != quadrants_visited[-1]:
		if quadrants_visited.size() > 1 and quadrants_visited[-2] == quadrant:
			quadrants_visited.pop_back()
		else:
			quadrants_visited.append(quadrant)
