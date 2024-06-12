extends CharacterBody2D


const SPEED = 10000.0
const SPEED_ROLL = SPEED * 2.
const JUMP_VELOCITY = -300.0
const ROLL_DISTANCE_MAX = 5000

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animate_sprite = $AnimatedSprite2D
@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_right = $RayCastRight
var roll_distance = 0

# 当前状态state standing running jumping rolling
enum State { STANDING, RUNNING, JUMPING, ROLLING }
var state = State.STANDING
enum Command { STAND, RUN, JUMP, ROLL }


func enum_key(e, index):
	var keys = e.keys()
	for k in keys:
		if e[k] == index:
			return k

func handle_standing():
	state = State.STANDING
	animate_sprite.play('idle')
	velocity.x = 0
	velocity.y = 0
	roll_distance = 0
	
func handle_running():
	state = State.RUNNING
	animate_sprite.play('run')
	
func handle_jumping():
	state = State.JUMPING
	animate_sprite.play('jump')
	velocity.y = JUMP_VELOCITY
	roll_distance = 0

func handle_rolling():
	state = State.ROLLING
	animate_sprite.play('roll')
# input: stand run jump roll
func handle_state(command):
	print(enum_key(State, state),'-->',enum_key(Command, command))
	match state:
		State.STANDING:
			if command == Command.RUN:
				handle_running.call()
			if command == Command.ROLL:
				handle_rolling.call()
			if command == Command.JUMP:
				handle_jumping.call()
		State.RUNNING:
			if command == Command.STAND:
				handle_standing.call()
			if command == Command.ROLL:
				handle_rolling.call()
			if command == Command.JUMP:
				handle_jumping.call()
		State.JUMPING:
			if command == Command.STAND:
				handle_standing.call()
		State.ROLLING:
			roll_distance = 0
			if command == Command.STAND:
				handle_standing.call()
			
	print('----',enum_key(State, state))
	

func _physics_process(delta):
	var direction = Input.get_axis('move_left','move_right')
	if direction == 1:
		animate_sprite.flip_h = false
	if direction == -1:
		animate_sprite.flip_h = true
		
	#standing -> running
	if is_on_floor() && direction && state == State.STANDING:
		print('#standing -> running')
		handle_state(Command.RUN)
		
	#standing -> rolling
	if state == State.STANDING && Input.is_action_just_pressed('roll'):
		print('#standing -> rolling')
		handle_state(Command.ROLL)
	
	# rolling -> standing
	if state == State.ROLLING:
		roll_distance += velocity.x
	if (state == State.ROLLING && 
			(
				abs(roll_distance) >= ROLL_DISTANCE_MAX ||
				(!animate_sprite.flip_h && ray_cast_right.is_colliding()) || 
				(animate_sprite.flip_h && ray_cast_left.is_colliding())
			)
		):
		print('# rolling -> standing')
		handle_state(Command.STAND)
	
	# running -> standing
	if is_on_floor() && !direction && state == State.RUNNING:
		print('# running -> standing')
		handle_state(Command.STAND)
	# running -> rolling
	if state == State.RUNNING && Input.is_action_just_pressed('roll'):
		print('# running -> rolling')
		handle_state(Command.ROLL)
	# running -> jumping
	if state == State.RUNNING && Input.is_action_just_pressed('jump'):
		print('# running -> jumping')
		handle_state(Command.JUMP)

	# standing -> jumping running -> jumping
	if Input.is_action_just_pressed('jump') && (state == State.STANDING || state == State.RUNNING):
		print('# standing -> jumping running -> jumping')
		handle_state(Command.JUMP)
		
	# jumping -> standing
	if is_on_floor() && state == State.JUMPING && velocity.y == 0:
		print('# jumping -> standing')
		handle_state(Command.STAND)
	
	var speed = SPEED_ROLL if state == State.ROLLING else SPEED
	var dir = direction
	if state == State.ROLLING:
		dir = -1 if animate_sprite.flip_h else 1
	
	velocity.x = speed * dir * delta
	velocity.y += gravity * delta
	
	move_and_slide()
