class_name CollectibleAsteroid
extends RigidBody2D


@export var clockwise: bool = true
@export_group("Nodes")
@export var sprite: Sprite2D
@export var revolution_progess: TextureProgressBar

@onready var player_revolution_component: PlayerRevolutionComponent = $PlayerRevolutionComponent as PlayerRevolutionComponent


func _ready() -> void:
	if clockwise:
		sprite.texture = Globals.CLOCKWISE_ASTEROID_DATA.sprites.pick_random()
		revolution_progess.tint_over = Globals.CLOCKWISE_ASTEROID_DATA.color
		revolution_progess.tint_progress = Globals.CLOCKWISE_ASTEROID_DATA.color
		revolution_progess.tint_progress.a = 0.25

	else:
		sprite.texture = Globals.COUNTERCLOCKWISE_ASTEROID_DATA.sprites.pick_random()
		revolution_progess.tint_over = Globals.COUNTERCLOCKWISE_ASTEROID_DATA.color
		revolution_progess.tint_progress = Globals.COUNTERCLOCKWISE_ASTEROID_DATA.color
		revolution_progess.tint_progress.a = 0.25


func _on_player_revolved(_clockwise: bool) -> void:
	Globals.player.add_asteroid_to_queue(clockwise)
	call_deferred(&"queue_free")


func _physics_process(_delta: float) -> void:
	if not linear_velocity:
		return

	var vel_sq: float = linear_velocity.length_squared()
	var vel_dir: Vector2 = linear_velocity.normalized()

	apply_central_force(-1 * 0.02 * vel_sq * vel_dir)


func _on_despawn_timer_timeout() -> void:
	queue_free()
