extends CharacterBody2D


@onready var player_rotation_detection_component: PlayerRotationDetectionComponent = $PlayerRotationDetectionComponent
@onready var label: Label = $Label


func _process(_delta: float) -> void:
	label.text = str("%d" % player_rotation_detection_component.quadrants_visited.size())
