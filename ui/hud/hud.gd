extends Control


@onready var boss_health_bar: ProgressBar = %BossHealthBar as ProgressBar
@onready var boss_poise_bar: ProgressBar = %BossPoiseBar as ProgressBar


func _ready() -> void:
	SignalBus.boss_ready.connect(_on_boss_ready)
	SignalBus.boss_vitals_changed.connect(_on_boss_vitals_changed)


func _on_boss_ready() -> void:
	boss_health_bar.max_value = Globals.boss.health_component.max_health
	boss_health_bar.value = Globals.boss.health_component.current_health
	boss_poise_bar.max_value = Globals.boss.poise_component.max_poise
	boss_poise_bar.value = Globals.boss.poise_component.current_poise


func _on_boss_vitals_changed() -> void:
	boss_health_bar.value = Globals.boss.health_component.current_health
	boss_poise_bar.value = Globals.boss.poise_component.current_poise
