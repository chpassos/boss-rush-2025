class_name PlayerRevolutionComponent
extends Node2D


signal player_revolved(clockwise: bool)

@export_range(0.0, 200.0, 10.0, "or_greater", "suffix:px") var max_distance: float

var angle: float:
	get:
		var ang: float = global_position.angle_to_point(Globals.player.global_position) - zero
		if ang >= 0:
			return ang
		else:
			return TAU + ang
var player_sq_dist: float:
	get:
		return global_position.distance_squared_to(Globals.player.global_position)

@onready var max_sq_dist: float = max_distance ** 2
@onready var zero: float = INF
@onready var revolution_progress: float = 0.0


func _physics_process(_delta: float) -> void:
	if not Globals.player:
		return

	if player_sq_dist > max_sq_dist:
		zero = INF
		return

	if zero == INF:
		zero = global_position.angle_to_point(Globals.player.global_position)

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
