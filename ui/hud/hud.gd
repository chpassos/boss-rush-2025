extends Control


@onready var boss_health_bar: ProgressBar = %BossHealthBar as ProgressBar
@onready var boss_poise_bar: ProgressBar = %BossPoiseBar as ProgressBar
@onready var player_health_bar: ProgressBar = %PlayerHealthBar as ProgressBar
@onready var speedrun_timer: Label = %SpeedrunTimer as Label
@onready var tween: Tween


func _ready() -> void:
	hide()

	SignalBus.camera_animation_finished.connect(_on_camera_animation_finished)

	SignalBus.player_ready.connect(_on_player_ready)
	SignalBus.player_vitals_changed.connect(_on_player_vitals_changed)

	SignalBus.boss_ready.connect(_on_boss_ready)
	SignalBus.boss_vitals_changed.connect(_on_boss_vitals_changed)

	SpeedrunTimer.start()  # TODO: move this to another script


func _on_camera_animation_finished(anim_name: StringName) -> void:
	if anim_name == &"intro":
		show()
		tween = create_tween()
		tween.tween_property(
			boss_health_bar,
			^"value",
			Globals.boss.health_component.current_health,
			2.0
		)
		tween.parallel().tween_property(
			boss_poise_bar,
			^"value",
			Globals.boss.poise_component.current_poise,
			2.0
		)
		tween.parallel().tween_property(
			player_health_bar,
			^"value",
			Globals.player.health_component.current_health,
			2.0
		)


func _process(_delta: float) -> void:
	speedrun_timer.text = Utils.time_to_text(SpeedrunTimer.elapsed_time)


func _on_player_ready() -> void:
	player_health_bar.max_value = Globals.player.health_component.max_health
	#player_health_bar.value = Globals.player.health_component.current_health


func _on_player_vitals_changed() -> void:
	player_health_bar.value = Globals.player.health_component.current_health


func _on_boss_ready() -> void:
	boss_health_bar.max_value = Globals.boss.health_component.max_health
	#boss_health_bar.value = Globals.boss.health_component.current_health
	boss_poise_bar.max_value = Globals.boss.poise_component.max_poise
	#boss_poise_bar.value = Globals.boss.poise_component.current_poise


func _on_boss_vitals_changed() -> void:
	boss_health_bar.value = Globals.boss.health_component.current_health
	boss_poise_bar.value = Globals.boss.poise_component.current_poise
