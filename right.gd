extends Area2D

func clicked():
	var revolver = get_parent().get_parent().get_node("Area2D")
	if(revolver.is_cocked()):
		revolver.fired()
		if(revolver.get_ammo() >= 0):
			var rightHitTexture = preload("res://Sprites/right_hit.png")
			get_child(0).set_texture(rightHitTexture)
			get_parent().kill()
		elif(revolver.get_ammo() <= 0):
			print("no ammo")
	else:
		print("Cock gun")