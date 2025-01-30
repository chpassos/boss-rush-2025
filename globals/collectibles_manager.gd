extends Node2D


func spawn_heal_asteroid(gpos: Vector2) -> void:
	var asteroid: HealAsteroid = Globals.HEAL_ASTEROID_SCENE.instantiate() as HealAsteroid
	asteroid.global_position = gpos
	add_child(asteroid)


func spawn_clockwise_asteroid(gpos: Vector2) -> void:
	var asteroid: CollectibleAsteroid = Globals.COLLECTIBLE_ASTEROID_SCENE.instantiate() as CollectibleAsteroid
	asteroid.global_position = gpos
	asteroid.clockwise = true
	add_child(asteroid)


func spawn_counterclockwise_asteroid(gpos: Vector2) -> void:
	var asteroid: CollectibleAsteroid = Globals.COLLECTIBLE_ASTEROID_SCENE.instantiate() as CollectibleAsteroid
	asteroid.global_position = gpos
	asteroid.clockwise = false
	add_child(asteroid)
