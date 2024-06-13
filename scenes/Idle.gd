extends State


#func enter():
	#player.velocity.x = 0

func update(delta):
	animate_sprite.play('idle')


func physics_update(delta):
	super.physics_update(delta)
	player.velocity.x = 0 # 应该在enter中，但是idle作为默认状态，enter却找不到player节点

	# standing -> running
	if player.is_on_floor() && direction:
		state_machine.transition_to('Run')

	# standing -> rolling
	if Input.is_action_just_pressed('roll'):
		state_machine.transition_to('Roll')

	# standing -> jumping
	if Input.is_action_just_pressed('jump'):
		state_machine.transition_to('Jump')
