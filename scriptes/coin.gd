class_name Coin
extends Area2D


@onready var collision = $CollisionShape2D
@onready var sound = $AudioStreamPlayer2D
@onready var animate_sprite = $AnimatedSprite2D
@onready var timer = $Timer


func _on_body_entered(body):
	if body is Player:
		sound.play()
		animate_sprite.visible = false
		collision.set_deferred("disabled", true)
		SignalBus.player_get_coin.emit()
		timer.start()
		await timer.timeout
		queue_free()
		
