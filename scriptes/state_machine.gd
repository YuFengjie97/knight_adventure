class_name StateMachine
extends Node

signal transitioned(state_name)

@export var initial_state := NodePath()
@onready var state: State = get_node(initial_state)
var state_pre: State


func _ready() -> void:
	await owner.ready
	state.enter()


func _physics_process(delta: float) -> void:
	state.update(delta)


func transition_to(next_state_str: String) -> void:
	if not has_node(next_state_str):
		return
		
	state.exit()
	state_pre = state
	state = get_node(next_state_str)
	state.enter()
	
	emit_signal('transitioned', state.name)
	
	
func transition_to_pre():
	transition_to(state_pre.name)

