extends State


func update(delta):
	animate_sprite.play('run')


func physics_update(delta):
	super.physics_update(delta)
	
	player.velocity.x = SPEED * direction * delta
	
	if player.is_on_floor() && !direction:
		state_machine.transition_to('Idle')
		
	if Input.is_action_just_pressed('roll'):
		state_machine.transition_to('Roll')
		
	if Input.is_action_just_pressed('jump'):
		state_machine.transition_to('Jump')
