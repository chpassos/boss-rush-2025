class_name PlayerRevolutionComponent
extends Node


signal player_revolved(clockwise: bool)

@export var actor: CharacterBody2D
@export_range(0.0, 200.0, 10.0, "or_greater", "suffix:px") var max_distance: float

var angle: float:
	get:
		var ang: float = actor.global_position.angle_to_point(player.global_position) - zero
		if ang >= 0:
			return ang
		else:
			return TAU + ang
var player_sq_dist: float:
	get:
		return actor.global_position.distance_squared_to(player.global_position)

@onready var player: Player = get_tree().get_first_node_in_group(&"player") as Player
@onready var max_sq_dist: float = max_distance ** 2
@onready var zero: float = INF
@onready var revolution_progress: float = 0.0


func _physics_process(_delta: float) -> void:
	if player_sq_dist > max_sq_dist:
		zero = INF
		return

	if zero == INF:
		zero = actor.global_position.angle_to_point(player.global_position)

	var pdelta: float = angle - revolution_progress

	if absf(pdelta) > PI / 2:
		pdelta -= TAU

	revolution_progress += pdelta

	if absf(revolution_progress) >= TAU - 0.05:
		if revolution_progress > 0:
			player_revolved.emit(true)
		else:
			player_revolved.emit(false)

		revolution_progress = 0.0
