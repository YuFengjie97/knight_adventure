class_name Heart
extends TextureRect

var heart_atals = preload("res://sprites/heart.tres")
var heart_null_atals = preload("res://sprites/heart_null.tres")

func update(is_full: bool):
	if is_full:
		texture = heart_atals
	else:
		texture = heart_null_atals
