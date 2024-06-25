class_name Player
extends CharacterBody2D

var state = 'Idle'
var collision_disable = false
var health = 1: set = set_health
var health_max = 1: set = set_health_max


@onready var collision_shape = $CollisionShape2D
@onready var timer = $Timer

func _ready():
	await owner.ready
	health_max = 4
	health = 4
	SignalBus.update_health_ui.emit(health, health_max)
	SignalBus.fruit_eat_by_player.connect(handle_eat_fruit)
	SignalBus.kill_zone_kill_player.connect(kill_by_kill_zone)


func set_health(value):
	health = clamp(value, 0, health_max)
	SignalBus.update_health_ui.emit(health, health_max)
	if health == 0:
		timer.start()
		await timer.ready
		get_tree().reload_current_scene()


func set_health_max(value):
	health_max = clamp(value, 1, 10)
	

func handle_eat_fruit():
	health_max += 1
	health += 1
	SignalBus.update_health_ui.emit(health, health_max)


func kill_by_kill_zone():
	health = 0
	SignalBus.update_health_ui.emit(health, health_max)
	

func _on_state_machine_transitioned(state_name):
	state = state_name
