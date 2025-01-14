extends Node2D


var type : Projectile:
	set(value):
		type = value
		$Sprite2D.texture = value.texture

func _on_vanish_timer_timeout():
	queue_free()
