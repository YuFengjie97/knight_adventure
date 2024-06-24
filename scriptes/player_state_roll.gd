extends PlayerState

const SPEED_ROLL = SPEED * 2.
const ROLL_MAX_DISTANCE = 5000

func enter():
	super.enter()
	animate_sprite.play('roll')
	roll_distance = 0


func update(_delta):
	super.update(_delta)
	player.velocity.x = SPEED_ROLL * face_direction * _delta
	roll_distance += abs(player.velocity.x)
	if (
		roll_distance >= ROLL_MAX_DISTANCE
		|| ray_cast_left.is_colliding()
		|| ray_cast_right.is_colliding()
	):
		state_machine.transition_to('Idle')
		return

