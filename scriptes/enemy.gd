class_name Enemy
extends RigidBody2D


@onready var kill_zone_collision_shape = $KillZone/CollisionShape2D
@onready var collision_shape = $CollisionShape2D
@onready var animate_sprite = $AnimatedSprite2D
@onready var death_timer = $Timer
#@onready var animation_player: AnimationPlayer = $AnimationPlayer


func die():
	death_timer.start()
	animate_sprite.play('hit')
	kill_zone_collision_shape.set_deferred('disabled', true)
	collision_shape.queue_free()
	kill_zone_collision_shape.queue_free()
	#animation_player.stop(true)
	#animation_player.queue_free()
	

func _on_body_entered(body):
	print('rigidbody body enter',body)
	#print('enemy body enter--', body.state)
	#if body.state == 'Roll':
		#print('enemy die')
		#die()
	#if not body.state == 'Roll':
		#print('player die')


func _on_timer_timeout():
	pass
	#queue_free()

