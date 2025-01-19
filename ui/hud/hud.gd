extends Control


@onready var boss_health_bar: ProgressBar = %BossHealthBar as ProgressBar
@onready var boss_poise_bar: ProgressBar = %BossPoiseBar as ProgressBar
@onready var player_health_bar: ProgressBar = %PlayerHealthBar as ProgressBar
@onready var speedrun_timer: Label = %SpeedrunTimer as Label


func _ready() -> void:
	SignalBus.player_ready.connect(_on_player_ready)
	SignalBus.player_vitals_changed.connect(_on_player_vitals_changed)

	SignalBus.boss_ready.connect(_on_boss_ready)
	SignalBus.boss_vitals_changed.connect(_on_boss_vitals_changed)

	SpeedrunTimer.start()  # TODO: move this to another script


func _process(_delta: float) -> void:
	speedrun_timer.text = "%.2f" % SpeedrunTimer.elapsed_time


func _on_player_ready() -> void:
	player_health_bar.max_value = Globals.player.health_component.max_health
	player_health_bar.value = Globals.player.health_component.current_health


func _on_player_vitals_changed() -> void:
	player_health_bar.value = Globals.player.health_component.current_health


func _on_boss_ready() -> void:
	boss_health_bar.max_value = Globals.boss.health_component.max_health
	boss_health_bar.value = Globals.boss.health_component.current_health
	boss_poise_bar.max_value = Globals.boss.poise_component.max_poise
	boss_poise_bar.value = Globals.boss.poise_component.current_poise


func _on_boss_vitals_changed() -> void:
	boss_health_bar.value = Globals.boss.health_component.current_health
	boss_poise_bar.value = Globals.boss.poise_component.current_poise
