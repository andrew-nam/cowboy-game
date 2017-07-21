extends Area2D

var disarm = false setget set_disarm, get_disarm

func set_disarm():
	disarm = true
	if(get_parent().get_dynamite()):
		if(get_parent().get_node("arm_r").get_disarm()):
			get_parent().get_parent().non_lethal()
	elif(get_parent().get_l_handedness()):
		get_parent().get_parent().non_lethal()

func get_disarm():
	return disarm

func shot():
	if(!disarm):
		if(rand_range(0, 1) > .75):
			print("hit")
			var level = get_tree().get_root().get_node("Level")
			level.damage()
			print(level.get_health())
		else:
			print("miss")

func clicked():
	var revolver = get_parent().get_parent().get_parent().get_node("Area2D")
	if(revolver.is_cocked()):
		revolver.fired()
		if(revolver.get_node(str("Barrel/Bullet", revolver.get_chamber())).is_visible()):
			if((!get_parent().get_l_handedness()) && get_parent().get_dynamite()):
				print("boom")
				get_parent().get_parent().lethal()
				var level = get_tree().get_root().get_node("Level")
				level.damage()
				return
#			var rightHitTexture = preload("res://Sprites/left.png")
#			get_child(0).set_texture(rightHitTexture)
			set_disarm()
		elif(!revolver.get_node(str("Barrel/Bullet", revolver.get_chamber())).is_visible()):
			print("no ammo")
	else:
		print("Cock gun")