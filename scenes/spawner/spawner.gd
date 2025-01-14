extends Node2D

@export var projectiles : PackedScene # Projectile scene to instantiate
@export var projectile_types: Array[Projectile]

@onready var screen_size = get_viewport().get_visible_rect().size # get screen size

# Spawn projectiles
func spawn(pos: Vector2):
	var projectile_instance = projectiles.instantiate()
	projectile_instance.type = projectile_types[randi_range(0,1)]
	#print(projectile_instance.type)
	projectile_instance.global_position = pos
	get_tree().current_scene.add_child(projectile_instance)

func _on_spawn_timer_timeout():
	var random_x = randi_range(0, screen_size.x)
	var random_y = randi_range(0, screen_size.y)
	spawn(Vector2(random_x, random_y))
