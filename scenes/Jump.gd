extends State


func enter():
	super.enter()
	player.velocity.y = JUMP_VELOCITY


func update(delta):
	animate_sprite.play('jump')


func physics_update(delta):
	super.physics_update(delta)
	player.velocity.x = SPEED * direction * delta
	
	# jumping -> standing
	if player.is_on_floor() && player.velocity.y == 0:
		state_machine.transition_to('Idle')

