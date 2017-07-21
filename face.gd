extends Area2D

func clicked():
	var revolver = get_parent().get_parent().get_parent().get_node("Area2D")
	if(revolver.is_cocked() && revolver.get_node(str("Barrel/Bullet", revolver.get_chamber())).is_visible()):
		revolver.fired()
		get_parent().get_parent().lethal()
	else:
		print("Cock gun")
