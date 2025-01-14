class_name PlayerRotationDetectionComponent
extends Node


signal rotation_detected(clockwise: bool)

@export var actor: CharacterBody2D

var angle: float:
	get:
		var ang: float = actor.global_position.angle_to_point(player.global_position) - zero
		if ang >= 0:
			return ang
		else:
			return TAU + ang

@onready var player: Player = get_tree().get_first_node_in_group(&"player") as Player
@onready var zero: float = actor.global_position.angle_to_point(player.global_position)
@onready var rotation_progress: float = 0.0


func _physics_process(_delta: float) -> void:
	var pdelta: float = angle - rotation_progress

	if absf(pdelta) > PI / 2:
		pdelta -= TAU

	rotation_progress += pdelta

	if absf(rotation_progress) >= TAU - 0.05:
		if rotation_progress > 0:
			rotation_detected.emit(true)
		else:
			rotation_detected.emit(false)

		rotation_progress = 0.0
