extends State

func enter():
	super.enter()
	roll_distance = 0

func update(_delta):
	animate_sprite.play('roll')
	

func physics_update(_delta):
	super.physics_update(_delta)
	# 因为你是在父类的process通过input的direction去判断face_direction
	# 并且每个子类对变量是单独的引用，我竟然忘了这一点
	# 而animate_sprite是一个对象，对它的引用，所有子类是相同的，所以状态是正确同步的
	# 将face_direction定义为类变量（静态变量）或者在每一帧通过aniamte_sprite.flip_h修改face_direction可以解决这个问题
	player.velocity.x = SPEED_ROLL * face_direction * _delta
	#player.velocity.x = SPEED_ROLL * (-1 if animate_sprite.flip_h else 1) * delta
	roll_distance += player.velocity.x
	
	if (
			abs(roll_distance) >= ROLL_DISTANCE_MAX
			|| (face_direction == 1 && ray_cast_right.is_colliding())
			|| (face_direction == -1 && ray_cast_left.is_colliding())
		):
		state_machine.transition_to('Idle')
	
