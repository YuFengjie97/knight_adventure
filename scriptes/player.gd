class_name Player
extends CharacterBody2D


var state = 'Idle'
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func die():
	print('player die')
	#get_tree().reload_current_scene()
	
func _physics_process(delta):
	velocity.y += gravity * delta
	move_and_slide()
	

func _on_state_machine_transitioned(state_name):
	state = state_name
	#print('player state--', state)
