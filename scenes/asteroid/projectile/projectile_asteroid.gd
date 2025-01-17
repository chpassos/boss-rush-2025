class_name ProjectileAsteroid
extends Area2D


@export var clockwise: bool = true
@export var speed: float = 250.0
@export_group("Nodes")
@export var sprite: Sprite2D

var direction: Vector2 = Vector2.RIGHT

#func _ready() -> void:
	#if clockwise:
		#sprite.texture = Globals.CLOCKWISE_ASTEROID_DATA.sprites.pick_random()
	#else:
		#sprite.texture = Globals.COUNTERCLOCKWISE_ASTEROID_DATA.sprites.pick_random()


func _process(delta: float) -> void:
	global_position += delta * speed * direction


func _on_body_entered(body: Boss) -> void:
	if not body:
		return

	body.take_damage(1)

	call_deferred(&"queue_free")
