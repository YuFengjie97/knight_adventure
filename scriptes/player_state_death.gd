extends PlayerState


func enter():
	super.enter()
	animate_sprite.play('death')


func update(_delta):
	super.update(_delta)

