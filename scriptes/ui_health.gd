extends Node2D


var health_max = 1
var health = 1
var heart_atals = "res://sprites/heart.tres"
var heart_null_atals = "res://sprites/heart_null.tres"
var Heart = preload("res://scenes/heart.tscn")

@onready var container = $HFlowContainer

func init():
	var childs = container.get_children()
	for child in childs:
		child.queue_free()
	for i in range(health):
		var heart = Heart.instantiate()
		heart.update(true)
		container.add_child(heart)
	for i in range(health_max - health):
		var heart = Heart.instantiate()
		heart.update(false)
		container.add_child(heart)


func _ready():
	SignalBus.update_health_ui.connect(update)


func update(v1, v2):
	health = v1
	health_max = v2
	init()
