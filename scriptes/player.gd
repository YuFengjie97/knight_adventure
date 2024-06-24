class_name Player
extends CharacterBody2D

var state = 'Idle'
var collision_disable = false
var health = 1: set = set_health
var health_max = 1: set = set_health_max


@onready var collision_shape = $CollisionShape2D


func _ready():
	await owner.ready
	health_max = 4
	health = 4


func set_health(value):
	health = clamp(value, 0, health_max)
	SignalBus.update_health_ui.emit(health, health_max)


func set_health_max(value):
	health_max = clamp(value, 1, 10)
	SignalBus.update_health_ui.emit(health, health_max)
	

func _on_state_machine_transitioned(state_name):
	state = state_name
