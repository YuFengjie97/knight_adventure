class_name Enemy
extends CharacterBody2D

const HIT_FORCE = 100

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * 0.3
var animate_name = 'idle'
var move_distance = 0.0
var direction = 1: set = set_direction
var hit_from_right = true # false hit from left
var is_die = false

@export var move_distance_max = 6000
@export var move_speed = 3000

@onready var animate_sprite = $AnimatedSprite2D
@onready var collision_shape = $CollisionShape2D
@onready var rc_l = $RayCastLeft
@onready var rc_r = $RayCastRight
@onready var rc_u = $RayCastUp
@onready var die_timer = $DieTimer
@onready var audio = $AudioStreamPlayer2D
@onready var rc_fw_r = $RayCastFindWayRight
@onready var rc_fw_l = $RayCastFindWayLeft


func set_direction(value):
	direction = value
	move_distance = 0

func die():
	audio.play()
	is_die = true
	animate_name = 'hit'
	collision_shape.disabled = true
	#collision_shape.call_deferred('is_disabled', true)
	die_timer.start()
	velocity = Vector2(-1 if hit_from_right else 1, -1).normalized() * HIT_FORCE



func _process(_delta):
	animate_sprite.play(animate_name)


func handleRC(rc: RayCast2D):
	if rc.is_colliding():
		var collider = rc.get_collider()
		if collider is Player:
			if collider.state == 'Roll':
				die()
				hit_from_right = rc.name == 'RayCastRight'
			else:
				if not is_die:
					SignalBus.enemy_hit_player.emit()

# 避免掉涯
func find_direction():
	if direction == 1 and not rc_fw_r.is_colliding():
		direction = -1
	if direction == -1 and not rc_fw_l.is_colliding():
		direction = 1


func _physics_process(delta):
	move_and_slide()
	velocity.y += gravity * delta
	if not is_die:
		velocity.x = move_speed * direction * delta
	move_distance += abs(velocity.x)
	if move_distance >= move_distance_max:
		direction *= -1
		move_distance = 0
		animate_sprite.flip_h = direction == -1
		
	handleRC(rc_l)
	handleRC(rc_r)
	handleRC(rc_u)
	find_direction()




func _on_die_timer_timeout():
	queue_free()
