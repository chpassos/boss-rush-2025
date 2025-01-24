extends Control


@export var title: Label
@export var dash: PanelContainer

@onready var tween: Tween


func _ready() -> void:
	play_intro_animation.call_deferred()


func play_intro_animation() -> void:
	title.modulate = Color.TRANSPARENT
	#var save_x: float = dash.position.x
	#dash.position.x += 500

	tween = create_tween()
	tween.tween_property(
		title,
		^"modulate",
		Color.WHITE,
		2.5
	).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN_OUT)
	#tween.tween_property(
		#dash,
		#^"position:x",
		#save_x,
		#1.0
	#).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
