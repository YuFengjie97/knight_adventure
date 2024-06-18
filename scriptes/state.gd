class_name State
extends Node

const SPEED = 10000.0
const SPEED_ROLL = SPEED * 2.
const JUMP_VELOCITY = -300.0
const ROLL_DISTANCE_MAX = 5000

var state_machine: StateMachine
var roll_distance = 0
static var face_direction = 1 # 1-right -1-left
var direction = 1 #-1 0 1

var player: CharacterBody2D
var animate_sprite: AnimatedSprite2D
var ray_cast_left: RayCast2D
var ray_cast_right: RayCast2D

func _ready():
	await owner.ready
	player = owner
	animate_sprite = owner.get_node('AnimatedSprite2D')
	ray_cast_left = owner.get_node('RayCastLeft')
	ray_cast_right = owner.get_node('RayCastRight')


func handle_input(_event: InputEvent) -> void:
	pass


func update(_delta: float) -> void:
	pass


func physics_update(_delta: float) -> void:
	direction = Input.get_axis('move_left', 'move_right')
	if direction == 1:
		face_direction = 1
		animate_sprite.flip_h = false
	if direction == -1:
		face_direction = -1
		animate_sprite.flip_h = true
	#face_direction = -1 if animate_sprite.flip_h else 1

	
	
	

func enter() -> void:
	pass
	#state_machine.state_str = name
	#print('enter state--', state_machine.state_str)
	#print('state enter ', name, ' ', direction, ' ', face_direction)


func exit() -> void:
	pass
