extends Node


func clear_asteroids() -> void:
	for child: Node in get_children():
		child.queue_free()


func spawn_projectile(global_position: Vector2, clockwise: bool, direction: Vector2) -> void:
	var projectile: ProjectileAsteroid = Globals.PROJECTILE_ASTEROID_SCENE.instantiate() as ProjectileAsteroid
	projectile.global_position = global_position
	projectile.clockwise = clockwise
	projectile.direction = direction

	add_child(projectile)
