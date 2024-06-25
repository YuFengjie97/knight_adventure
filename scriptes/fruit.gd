class_name Fruit
extends Area2D


var is_eat = false

@onready var collision = $CollisionShape2D
@onready var audio = $AudioStreamPlayer2D
@onready var animate = $AnimationPlayer


func _on_body_entered(body):
	if not is_eat:
		SignalBus.fruit_eat_by_player.emit()
		animate.play('eat')
		is_eat = true
