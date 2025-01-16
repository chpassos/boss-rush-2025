extends RigidBody2D


@export var data: AsteroidData
@export_group("Nodes")
@export var sprite: Sprite2D
@export var player_revolution: PlayerRevolutionComponent


func _draw() -> void:
	draw_circle(Vector2.ZERO, player_revolution.max_distance, data.color, false)


func _ready() -> void:
	#sprite.modulate = data.color
	sprite.texture = data.sprite
	player_revolution.player_revolved.connect(_on_player_revolved)


func _on_player_revolved(_clockwise: bool) -> void:
	player_revolution.player.add_asteroid(data)
	call_deferred(&"queue_free")
