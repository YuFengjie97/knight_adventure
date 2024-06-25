class_name KillZone
extends Area2D


var player: Player


func _on_body_entered(_body):
	SignalBus.kill_zone_kill_player.emit()
