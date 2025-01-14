extends CharacterBody2D


@onready var rotation_detection: PlayerRotationDetectionComponent = $PlayerRotationDetectionComponent
@onready var label: Label = $Label


func _draw() -> void:
	draw_circle(global_position, rotation_detection.max_distance, Color.BLACK, false)


func _process(_delta: float) -> void:
	label.text = str("%d" % rad_to_deg(rotation_detection.rotation_progress))
