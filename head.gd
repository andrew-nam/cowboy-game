extends Node2D

var set_mask = funcref(self, "set_sprite")
var courage = false setget set_courage, get_courage

func get_func():
	return set_mask

func set_sprite(flagIndex):
	if(flagIndex == 0):
		var maskSpecializationTexture = preload("res://Sprites/mask_r.png")
		get_node("mask").set_texture(maskSpecializationTexture)
	elif(flagIndex == 1):
		var maskSpecializationTexture = preload("res://Sprites/mask_g.png")
		get_node("mask").set_texture(maskSpecializationTexture)
	else:
		var maskSpecializationTexture = preload("res://Sprites/mask_b.png")
		get_node("mask").set_texture(maskSpecializationTexture)

func set_courage():
	courage = true

func get_courage():
	return courage

