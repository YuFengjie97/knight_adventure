class_name KillZone
extends Area2D

signal kill_zone_want_player_die

@onready var timer = $Timer
var player: Player


func _on_timer_timeout():
	pass
	#get_tree().reload_current_scene()



func _on_body_entered():
	print('kill zone body enter')
	timer.start()
	await timer.ready
	kill_zone_want_player_die.emit()
