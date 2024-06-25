extends PlayerState

@onready var state_hit = $"../Hit"

func enter():
	super.enter()
	animate_sprite.play('run')


func update(_delta):
	super.update(_delta)
	player.velocity.x = SPEED * direction * _delta
	if Input.is_action_just_pressed('roll'):
		state_machine.transition_to('Roll')
		return
	if direction == 0:
		state_machine.transition_to('Idle')
		return
	if Input.is_action_just_pressed('jump'):
		state_machine.transition_to('Jump')
		return
	if player.health == 0:
		state_machine.transition_to('Death')
		return
	
