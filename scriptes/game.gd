extends Node

@onready var player: Player = %Player


func _ready():
	var kill_zone_group = get_tree().get_nodes_in_group('kill_zone_group')
	for kill_zone: KillZone in kill_zone_group:
		kill_zone.kill_zone_want_player_die.connect(player.die)
