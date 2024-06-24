extends PlayerState

@onready var hit_timer: Timer = $HitTimer
@onready var sound_hit: AudioStreamPlayer2D = $SoundHit

var is_hit = false # player 被攻击

func _ready():
	super._ready()
	SignalBus.enemy_hit_player.connect(hit_by_enemy)


func hit_by_enemy():
	if not is_hit and player.health != 0:
		is_hit = true
		hit_timer.start()
		sound_hit.play()
		player.health -= 1
		await hit_timer.timeout
		is_hit = false

func enter():
	animate_sprite.play('hit')


func update(_delta):
	super.update(_delta)
	player.velocity.x = SPEED * direction * _delta
	if is_hit:
		return
	if player.health == 0:
		state_machine.transition_to('Death')
		return
	if player.is_on_floor() and not direction:
		state_machine.transition_to('Idle')
		return
	if player.is_on_floor() and direction:
		state_machine.transition_to('Run')
		return
	if player.is_on_floor() and Input.is_action_just_pressed('roll'):
		state_machine.transition_to('Roll')
		return
	if player.is_on_floor() and Input.is_action_just_pressed('jump'):
		state_machine.transition_to('Jump')
		return
	
	
