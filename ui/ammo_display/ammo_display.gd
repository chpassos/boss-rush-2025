class_name AmmoDisplay
extends Node2D


@export var clockwise_ammo_counter: Label
@export var counterclockwise_ammo_counter: Label


func _process(_delta: float) -> void:
	global_position = get_global_mouse_position()
