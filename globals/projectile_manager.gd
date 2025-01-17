extends Node


func spawn_projectile(global_position: Vector2, clockwise: bool, direction: Vector2) -> void:
	var projectile: ProjectileAsteroid

	if clockwise:
		projectile = Globals.CLOCKWISE_ASTEROID_DATA.projectile_scene.instantiate() as ProjectileAsteroid
	else:
		projectile = Globals.COUNTERCLOCKWISE_ASTEROID_DATA.projectile_scene.instantiate() as ProjectileAsteroid

	projectile.global_position = global_position
	projectile.direction = direction

	add_child(projectile)
