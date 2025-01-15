extends CharacterBody2D


@export var light_color: Color = Color.WHITE
@export_group("Nodes")
@export var sprite: Sprite2D
@export var light: PointLight2D


func _ready() -> void:
	sprite.modulate = light_color
	light.color = light_color
