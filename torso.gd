extends Node2D

var set_body = funcref(self, "set_sprite")
var body_flags = [false, false, false]
var armor = false

func get_func():
	return set_body

func set_sprite(flagIndex):
	if(flagIndex == 0):
		var bodySpecializationTextureL = preload("res://Sprites/Shirt/red_shirt_l.png")
		var bodySpecializationTextureR = preload("res://Sprites/Shirt/red_shirt_r.png")
		get_node("shirt_l").set_texture(bodySpecializationTextureL)
		get_node("shirt_r").set_texture(bodySpecializationTextureR)
		body_flags[flagIndex] = true
	elif(flagIndex == 1):
		var bodySpecializationTextureL = preload("res://Sprites/Shirt/green_shirt_l.png")
		var bodySpecializationTextureR = preload("res://Sprites/Shirt/green_shirt_r.png")
		get_node("shirt_l").set_texture(bodySpecializationTextureL)
		get_node("shirt_r").set_texture(bodySpecializationTextureR)
		body_flags[flagIndex] = true
	else:
		var bodySpecializationTextureL = preload("res://Sprites/Shirt/blue_shirt_l.png")
		var bodySpecializationTextureR = preload("res://Sprites/Shirt/blue_shirt_r.png")
		get_node("shirt_l").set_texture(bodySpecializationTextureL)
		get_node("shirt_r").set_texture(bodySpecializationTextureR)
		body_flags[flagIndex] = true

func get_body_flags():
	return body_flags

func set_armor():
	armor = true

func clicked():
	var revolver = get_parent().get_parent().get_parent().get_node("Area2D")
	if(revolver.is_cocked()):
		revolver.fired()
		if(revolver.get_node(str("Barrel/Bullet", revolver.get_chamber())).is_visible() && !armor):
			get_parent().get_parent().lethal()
		elif(revolver.get_node(str("Barrel/Bullet", revolver.get_chamber())).is_visible() && armor):
			print("Twang")
	else:
		print("Cock gun")