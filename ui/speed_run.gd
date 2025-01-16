extends CanvasLayer


func _ready() -> void:
	SpeedrunTimer.start()


func _process(_delta: float) -> void:
	($Label as Label).text = str("%.2f" % SpeedrunTimer.elapsed_time)
