extends Area2D

func is_hat():
	return true

func clicked():
	var revolver = get_parent().get_parent().get_parent().get_node("Area2D")
	if(revolver.is_cocked()):
		revolver.fired()
		if(revolver.get_node(str("Barrel/Bullet", revolver.get_chamber())).is_visible() && !get_parent().get_courage()):
			self.queue_free()
			get_parent().get_parent().non_lethal()
		elif(revolver.get_node(str("Barrel/Bullet", revolver.get_chamber())).is_visible() && get_parent().get_courage()):
			self.queue_free()
			print("unphased")
	else:
		print("Cock gun")