extends Sprite2D


@onready var player_revolution: PlayerRevolutionComponent = $PlayerRevolutionComponent


func _draw() -> void:
	draw_circle(Vector2.ZERO, player_revolution.max_distance, Color.WHITE, false)


func _ready() -> void:
	player_revolution.player_revolved.connect(_on_player_revolved)


func _on_player_revolved(_clockwise: bool) -> void:
	queue_free()
