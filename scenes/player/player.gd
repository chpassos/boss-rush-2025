class_name Player
extends CharacterBody2D


const SPEED = 100.0


func _physics_process(_delta: float) -> void:
	var input_dir: Vector2 = Input.get_vector(&"move_left", &"move_right", &"move_up", &"move_down")
	velocity = SPEED * input_dir
	move_and_slide()
