extends Area2D

var disarm = false setget set_disarm, get_disarm

func get_disarm():
	return disarm

func set_disarm():
	disarm = true
	
	if(get_parent().get_dynamite()):
		if(get_parent().get_node("arm_l").get_disarm()):
			get_parent().get_parent().non_lethal()
	elif(!get_parent().get_l_handedness()):
		get_parent().get_parent().non_lethal()

func shot():
	if(!disarm):
		if(rand_range(0, 1) > .75):
			print("hit")
			var level = get_tree().get_root().get_node("Level")
			level.damage()
		else:
			print("miss")


func clicked():
	var revolver = get_parent().get_parent().get_parent().get_node("Area2D")
	if(revolver.is_cocked()):
		revolver.fired()
		if(revolver.get_node(str("Barrel/Bullet", revolver.get_chamber())).is_visible()):
			if(get_parent().get_l_handedness() && get_parent().get_dynamite()):
				print("boom")
				get_parent().get_parent().lethal()
				var level = get_tree().get_root().get_node("Level")
				level.damage()
				return
#			
			var body_flags = get_parent().get_node("torso").get_body_flags()
			var disarm_anim = get_parent().get_node("hand_disarm")
			var anim_name = "r_hand"
	
			if(body_flags[0]):
				anim_name += "_r"
			elif(body_flags[1]):
				anim_name += "_g"
			elif(body_flags[2]):
				anim_name += "_b"
			else:
				anim_name += "_n"
	
			disarm_anim.play(anim_name)
			set_disarm()
		elif(!revolver.get_node(str("Barrel/Bullet", revolver.get_chamber())).is_visible()):
			print("no ammo")
	else:
		print("Cock gun")