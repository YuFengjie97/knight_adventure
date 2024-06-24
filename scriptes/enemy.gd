class_name Enemy
extends CharacterBody2D

const MOVE_DISTANCE_MAX = 6000
const MOVE_SPEED = 3000
const HIT_FORCE = 100

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * 0.3
var animate_name = 'idle'
var move_distance = 0.0
var direction = 1
var hit_from_right = true # false hit from left
var is_die = false
var player: Player

@onready var animate_sprite = $AnimatedSprite2D
@onready var collision_shape = $CollisionShape2D
@onready var rc_l = $RayCastLeft
@onready var rc_r = $RayCastRight
@onready var rc_u = $RayCastUp
@onready var die_timer = $DieTimer
@onready var audio = $AudioStreamPlayer2D


func die():
	print('enemy die')
	audio.play()
	is_die = true
	animate_name = 'hit'
	collision_shape.disabled = true
	die_timer.start()
	velocity = Vector2(-1 if hit_from_right else 1, -1).normalized() * HIT_FORCE


func _ready():
	await owner.ready
	player = owner.get_node('Player')


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
				SignalBus.enemy_hit_player.emit()
	

func _physics_process(delta):
	move_and_slide()
	velocity.y += gravity * delta
	if not is_die:
		velocity.x = MOVE_SPEED * direction * delta
	move_distance += abs(velocity.x)
	if move_distance >= MOVE_DISTANCE_MAX:
		direction *= -1
		move_distance = 0
		animate_sprite.flip_h = direction == -1
		
	handleRC(rc_l)
	handleRC(rc_r)
	handleRC(rc_u)




func _on_die_timer_timeout():
	queue_free()
