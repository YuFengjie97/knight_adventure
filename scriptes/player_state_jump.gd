extends PlayerState

const JUMP_VELOCITY = -300.0

@onready var sound_jump = $SoundJump
@onready var state_hit = $"../Hit"

func enter():
	super.enter()
	animate_sprite.play('jump')
	player.velocity.y = JUMP_VELOCITY
	sound_jump.play()


func update(_delta):
	super.update(_delta)
	player.velocity.x = SPEED * direction * _delta
	
	if player.velocity.y == 0:
		state_machine.transition_to('Idle')
		return
	if player.health == 0:
		state_machine.transition_to('Death')
		return


