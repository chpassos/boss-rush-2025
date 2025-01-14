extends Node2D



func _on_vanish_timer_timeout():
	queue_free()
