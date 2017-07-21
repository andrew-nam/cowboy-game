extends Node2D

var set_pants = funcref(self, "set_sprite")
var legs_flags = [false, false, false]

func get_func():
	return set_pants

func set_sprite(flagIndex):
	if(flagIndex == 0):
		var pantsSpecializationTexture = preload("res://Sprites/pants_r.png")
		get_child(0).set_texture(pantsSpecializationTexture)
		legs_flags[flagIndex] = true
	elif(flagIndex == 1):
		var pantsSpecializationTexture = preload("res://Sprites/pants_g.png")
		get_child(0).set_texture(pantsSpecializationTexture)
		legs_flags[flagIndex] = true
	else:
		var pantsSpecializationTexture = preload("res://Sprites/pants_b.png")
		get_child(0).set_texture(pantsSpecializationTexture)
		legs_flags[flagIndex] = true

func get_legs_flags():
	return legs_flags