extends Area2D

func clicked():
	var revolver = get_parent().get_parent().get_parent().get_node("Area2D")
	if(revolver.is_cocked()):
		revolver.fired()
		if(revolver.get_node(str("Barrel/Bullet", revolver.get_chamber())).is_visible()):
			get_parent().get_parent().get_node("body/arm_l").set_disarm()
	else:
		print("Cock gun")

