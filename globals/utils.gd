class_name Utils
extends Node


static func time_to_text(time_in_seconds: float) -> String:
	var hours: int = int(time_in_seconds / 3600)
	var minutes: int = int(time_in_seconds / 60) - 60 * hours
	var remaining: float = fmod(time_in_seconds, 60.0)
	var seconds: int = int(remaining)
	var milliseconds: int = int((remaining - seconds) * 1000)

	var text: String = "%02d.%03d" % [seconds, milliseconds]
	if minutes or hours:
		text = ("%02d:" % minutes) + text
	if hours:
		text = ("%02d:" % hours) + text

	return text
