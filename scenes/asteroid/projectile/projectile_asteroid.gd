class_name ProjectileAsteroid
extends Area2D


@export var speed: float = 250.0

var direction: Vector2 = Vector2.RIGHT


func _process(delta: float) -> void:
	global_position += delta * speed * direction


func _on_body_entered(body: Boss) -> void:
	if not body:
		return

	body.take_damage(1)

	call_deferred(&"queue_free")
