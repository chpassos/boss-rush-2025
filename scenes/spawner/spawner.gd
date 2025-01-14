extends Node2D


@export var projectiles : PackedScene # Projectile scene to instantiate

@onready var screen_size = get_viewport().get_visible_rect().size # get screen size



# Spawn projectiles
func spawn(pos: Vector2):
	var projectile_instance = projectiles.instantiate()
	
	projectile_instance.position = pos
	get_tree().current_scene.add_child(projectile_instance)

# Based on our screen size, we get a random position from it
func get_random_pos() -> Vector2:
	var random_x = randi_range(0, screen_size.x)
	var random_y = randi_range(0, screen_size.y)
	
	return screen_size

func _on_spawn_timer_timeout():
	spawn(get_random_pos())
