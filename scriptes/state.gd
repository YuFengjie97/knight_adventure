class_name State
extends Node

var state_machine: StateMachine


func update(_delta: float) -> void:
	pass


#func enter_condition() -> bool:
	#return true
#
#
#func exit_condition() -> bool:
	#return true


func enter() -> void:
	print('enter ', name)
	pass


func exit() -> void:
	print('exit ', name)
	pass


