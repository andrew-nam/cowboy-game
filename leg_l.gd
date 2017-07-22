extends Area2D

func clicked():
	var revolver = get_parent().get_parent().get_parent().get_node("Area2D")
	if(revolver.is_cocked()):
		revolver.fired()
		if(revolver.get_node(str("Barrel/Bullet", revolver.get_chamber())).is_visible()):
			var body_flags = get_parent().get_parent().get_node("body/torso").get_body_flags()
			var disarm_anim = get_parent().get_node("leg_disarm")
			var anim_name = "l_leg"
	
			if(body_flags[0]):
				anim_name += "_r"
			elif(body_flags[1]):
				anim_name += "_g"
			elif(body_flags[2]):
				anim_name += "_b"
			else:
				anim_name += "_n"
	
			disarm_anim.play(anim_name)
			get_parent().get_parent().get_node("body/arm_l").set_disarm()
	else:
		print("Cock gun")

