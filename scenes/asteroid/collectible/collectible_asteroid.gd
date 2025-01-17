class_name CollectibleAsteroid
extends RigidBody2D


@export var clockwise: bool = true
@export_group("Nodes")
@export var sprite: Sprite2D


func _ready() -> void:
	if clockwise:
		sprite.texture = Globals.CLOCKWISE_ASTEROID_DATA.sprites.pick_random()
	else:
		sprite.texture = Globals.COUNTERCLOCKWISE_ASTEROID_DATA.sprites.pick_random()


func _on_player_revolved(_clockwise: bool) -> void:
	Globals.player.add_asteroid_to_queue(clockwise)
	call_deferred(&"queue_free")


func _physics_process(_delta: float) -> void:
	if not linear_velocity:
		return

	var k: float = 0.025
	var vel_sq: float = linear_velocity.length_squared()
	var vel_dir: Vector2 = linear_velocity.normalized()

	apply_central_force(-1 * k * vel_sq * vel_dir)


func _on_despawn_timer_timeout() -> void:
	queue_free()
