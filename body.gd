extends Node2D

var l_handedness = false setget get_l_handedness
var dynamite = false setget set_dynamite, get_dynamite

func _ready():
	if(rand_range(0, 10) > 9):
		l_handedness = true

func set_dynamite():
	dynamite = true

func get_dynamite():
	return dynamite

func get_l_handedness():
	return l_handedness

func shot():
	if(!l_handedness):
		get_node("arm_r").shot()
	else:
		get_node("arm_l").shot()