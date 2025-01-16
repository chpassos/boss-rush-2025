extends CanvasLayer

var time : float = Globals.speedrun_time

func _physics_process(delta):
	time = time + delta
	update_ui()

func update_ui():
	var string_time = str(time)
	var decimal_index = string_time.find(".")
	if decimal_index > 0:
		string_time = string_time.left(decimal_index + 3)
		print(string_time)
	
	Globals.speedrun_time = string_time
	$Label.text = string_time
