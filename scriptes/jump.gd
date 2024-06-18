extends State


func enter():
	super.enter()
	player.velocity.y = JUMP_VELOCITY


func update(_delta):
	animate_sprite.play('jump')


func physics_update(_delta):
	super.physics_update(_delta)
	player.velocity.x = SPEED * direction * _delta
	
	# jumping -> standing
	if player.is_on_floor() && player.velocity.y == 0:
		state_machine.transition_to('Idle')

