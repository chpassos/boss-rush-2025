extends Sprite2D


@export var data: AsteroidData
@export var player_revolution: PlayerRevolutionComponent


func _draw() -> void:
	draw_circle(Vector2.ZERO, player_revolution.max_distance, Color.WHITE, false)


func _ready() -> void:
	modulate = data.color
	player_revolution.player_revolved.connect(_on_player_revolved)


func _on_player_revolved(_clockwise: bool) -> void:
	player_revolution.player.add_asteroid(data)
	call_deferred(&"queue_free")
