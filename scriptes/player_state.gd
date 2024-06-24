class_name PlayerState
extends State

const SPEED = 10000.0


var roll_distance = 0
static var face_direction = 1 # 1-right -1-left
static var direction = 1 #-1 0 1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var player: CharacterBody2D
var animate_sprite: AnimatedSprite2D
var ray_cast_left: RayCast2D
var ray_cast_right: RayCast2D

func _ready():
	await owner.ready
	player = owner
	state_machine = owner.get_node('StateMachine')
	animate_sprite = owner.get_node('AnimatedSprite2D')
	ray_cast_left = owner.get_node('RayCastLeft')
	ray_cast_right = owner.get_node('RayCastRight')


func update(_delta: float) -> void:
	if player.health == 0:
		return
	player.velocity.y += gravity * _delta
	player.move_and_slide()
	
	direction = Input.get_axis('move_left', 'move_right')
	if direction == 1:
		face_direction = 1
		animate_sprite.flip_h = false
	if direction == -1:
		face_direction = -1
		animate_sprite.flip_h = true
