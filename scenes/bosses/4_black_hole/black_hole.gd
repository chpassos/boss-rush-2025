extends Boss


@export var gravity_field: Area2D
@export var gravity_field_collision_shape: CollisionShape2D


func _ready() -> void:
	super._ready()
	take_damage(10, 0)


func _on_event_horizon_body_entered(body: Node2D) -> void:
	if body is CollectibleAsteroid:
		body.queue_free()
		heal(1)


# GRAVITY PULL ATTACK STATE

func _on_gravity_pull_state_entered() -> void:
	print("on")
	gravity_field_collision_shape.disabled = false


func _on_gravity_pull_state_exited() -> void:
	print("off")
	gravity_field_collision_shape.disabled = true
