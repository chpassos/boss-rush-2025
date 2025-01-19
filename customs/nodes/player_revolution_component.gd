class_name PlayerRevolutionComponent
extends Node2D


signal player_revolved(clockwise: bool)

@export_range(0.0, 200.0, 10.0, "or_greater", "suffix:px") var max_distance: float
@export var progress_bar: TextureProgressBar

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
		revolution_progress = 0.0
		progress_bar.value = 0.0
		return

	if zero == INF:
		zero = global_position.angle_to_point(Globals.player.global_position)
		progress_bar.radial_initial_angle = rad_to_deg(zero + PI / 2)

	var pdelta: float = angle - revolution_progress

	if absf(pdelta) > PI / 2:
		pdelta -= TAU

	revolution_progress += pdelta

	if revolution_progress < 0:
		progress_bar.fill_mode = TextureProgressBar.FillMode.FILL_COUNTER_CLOCKWISE
	else:
		progress_bar.fill_mode = TextureProgressBar.FillMode.FILL_CLOCKWISE

	progress_bar.value = absf(revolution_progress) / TAU

	if absf(revolution_progress) >= TAU - 0.05:
		if revolution_progress > 0:
			player_revolved.emit(true)
		else:
			player_revolved.emit(false)

		revolution_progress = 0.0
		progress_bar.value = 0.0