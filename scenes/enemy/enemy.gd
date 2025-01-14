extends CharacterBody2D


@onready var player_revolution: PlayerRevolutionComponent = $PlayerRevolutionComponent
@onready var label: Label = $Label


func _draw() -> void:
	draw_circle(Vector2.ZERO, player_revolution.max_distance, Color.WHITE, false)


func _process(_delta: float) -> void:
	label.text = str("%d" % rad_to_deg(player_revolution.revolution_progress))
