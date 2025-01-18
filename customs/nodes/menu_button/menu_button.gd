extends TextureButton


@export_range(0.0, 3.0, 0.1, "or_greater") var on_hover_scale: float = 2.0

@onready var tween: Tween


func _ready() -> void:
	pivot_offset = size / 2


func _on_mouse_entered() -> void:
	if tween:
		tween.kill()

	tween = create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_BOUND)
	tween.tween_property(
		self,
		^"scale",
		on_hover_scale * Vector2.ONE,
		0.1
	).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)


func _on_mouse_exited() -> void:
	if tween:
		tween.kill()

	tween = create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_BOUND)
	tween.tween_property(
		self,
		^"scale",
		Vector2.ONE,
		0.05
	)
