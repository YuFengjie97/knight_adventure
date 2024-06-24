extends Camera2D

var player: Player

func _ready():
	await owner.ready
	player = owner.get_node('Player')

func _physics_process(_delta):
	position = player.position
	
