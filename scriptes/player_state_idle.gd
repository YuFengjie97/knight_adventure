extends PlayerState


@onready var state_hit = $"../Hit"


func enter():
	super.enter()
	animate_sprite.play('idle')
	player.velocity.x = 0


func update(_delta):
	super.update(_delta)
	if direction != 0:
		state_machine.transition_to('Run')
		return
	if Input.is_action_just_pressed('roll'):
		state_machine.transition_to('Roll')
		return
	if Input.is_action_just_pressed('jump'):
		state_machine.transition_to('Jump')
		return
	if state_hit.is_hit:
		state_machine.transition_to('Hit')
		return
	
		
