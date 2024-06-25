extends PlayerState

@onready var sound_hit: AudioStreamPlayer2D = $SoundHit
@onready var timer = $Timer

var hit_disable = false

func _ready():
	super._ready()
	SignalBus.enemy_hit_player.connect(hit_by_enemy)


func hit_by_enemy():
	if not hit_disable:
		player.health -= 1
		hit_disable = true
		timer.start()
		var tween = get_tree().create_tween()
		tween.tween_property(animate_sprite, 'modulate', Color.RED, 0.1)
		tween.tween_property(animate_sprite, 'modulate', Color.WHITE, 0.1)
		tween.tween_property(animate_sprite, 'modulate', Color.RED, 0.1)
		tween.tween_property(animate_sprite, 'modulate', Color.WHITE, 0.1)


func _on_timer_timeout():
	hit_disable = false
