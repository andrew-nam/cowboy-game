extends Node2D

var set_pants = funcref(self, "set_sprite")
var dynamite = false

func get_func():
	return set_pants

func set_sprite(flagIndex):
	if(flagIndex == 0):
		var pantsSpecializationTexture = preload("res://Sprites/pants_r.png")
		get_child(0).set_texture(pantsSpecializationTexture)
	elif(flagIndex == 1):
		var pantsSpecializationTexture = preload("res://Sprites/pants_g.png")
		get_child(0).set_texture(pantsSpecializationTexture)
	else:
		var pantsSpecializationTexture = preload("res://Sprites/pants_b.png")
		get_child(0).set_texture(pantsSpecializationTexture)

func set_dynamite():
	dynamite = true


func clicked():
	var revolver = get_parent().get_parent().get_node("Area2D")
	if(revolver.is_cocked()):
		revolver.fired()
		if(revolver.get_ammo() >= 0 && !dynamite):
			var leftHitTexture = preload("res://Sprites/left_hit.png")
			get_child(0).set_texture(leftHitTexture)
			get_parent().kill()
		elif(revolver.get_ammo() >= 0 && dynamite):
			print("boom")
	else:
		print("Cock gun")