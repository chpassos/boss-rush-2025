extends Area2D


signal died()

@export var big_star: Boss
@export_range(0.0, 200.0, 5.0, "or_greater", "suffix:px") var orbiting_distace: float = 120.0
@export var angular_acceleration: float = 35.0
@export_group("Nodes")
@export var sprite: Sprite2D
@export var anim_player: AnimationPlayer
@export var health_component: HealthComponent

@onready var acceleration: float = deg_to_rad(angular_acceleration) * orbiting_distace
@onready var is_dead: bool = false


func _ready() -> void:
	died.connect(big_star._on_small_star_died)
	if not Globals.player:
		SignalBus.player_ready.connect(
			func():
				var angle: float = big_star.global_position.angle_to_point(Globals.player.global_position)
				var target_position: Vector2 = big_star.global_position + orbiting_distace * Vector2.RIGHT.rotated(angle)
				global_position = target_position
		)
	else:
		var angle: float = big_star.global_position.angle_to_point(Globals.player.global_position)
		var target_position: Vector2 = big_star.global_position + orbiting_distace * Vector2.RIGHT.rotated(angle)
		global_position = target_position


func _process(delta: float) -> void:
	if is_dead:
		return

	if not Globals.player:
		global_position = big_star.global_position + orbiting_distace * Vector2.RIGHT
		return

	var angle: float = big_star.global_position.angle_to_point(Globals.player.global_position)
	var target_position: Vector2 = big_star.global_position + orbiting_distace * Vector2.RIGHT.rotated(angle)
	global_position = global_position.move_toward(target_position, delta * acceleration)


func _on_area_entered(area: ProjectileAsteroid) -> void:
	if is_dead:
		return

	if not area:
		return

	anim_player.play(&"hit")

	if area.clockwise:
		health_component.take_damage(Globals.CLOCKWISE_ASTEROID_DATA.health_damage)
	else:
		health_component.take_damage(Globals.COUNTERCLOCKWISE_ASTEROID_DATA.health_damage)

	var p: float = float(health_component.current_health) / health_component.max_health
	if p <= 0.2:
		sprite.frame = 8
	elif p <= 0.4:
		sprite.frame = 46
	elif p <= 0.6:
		sprite.frame = 45
	elif p <= 0.8:
		sprite.frame = 44
	else:
		sprite.frame = 43

	area.queue_free()


func _on_health_component_health_depleted() -> void:
	is_dead = true
	died.emit()
	anim_player.queue(&"death")
	await anim_player.animation_finished
	queue_free.call_deferred()


func _on_body_entered(body: Node2D) -> void:
	if is_dead:
		return

	if not body is Player:
		return

	(body as Player).take_damage(1)
