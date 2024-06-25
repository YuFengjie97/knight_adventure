extends PlayerState

@onready var timer = $Timer


func enter():
	super.enter()
	animate_sprite.play('death')
	collision.queue_free()
	timer.start()
	await timer.timeout
	get_tree().reload_current_scene()


func update(_delta):
	super.update(_delta)

