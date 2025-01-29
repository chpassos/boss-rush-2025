extends Node


# PLAYER
@warning_ignore("unused_signal")
signal player_ready()
@warning_ignore("unused_signal")
signal player_vitals_changed()
@warning_ignore("unused_signal")
signal player_defeated()
# BOSS
@warning_ignore("unused_signal")
signal boss_ready()
@warning_ignore("unused_signal")
signal boss_vitals_changed()
@warning_ignore("unused_signal")
signal boss_defeated()
# ARENA
@warning_ignore("unused_signal")
signal arena_ready()
# CAMERA MANAGER
@warning_ignore("unused_signal")
signal camera_animation_finished(anim: StringName)
