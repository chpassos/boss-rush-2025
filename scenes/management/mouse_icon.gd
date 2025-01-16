extends Area2D

func _process(_delta):
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_HIDDEN)
	global_position = get_global_mouse_position()
