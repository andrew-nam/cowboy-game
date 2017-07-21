extends Area2D

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _input_event(viewport, event, shape_idx):
	if event.type == InputEvent.MOUSE_BUTTON \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		#intersect_point creates array of K-V pairs that contains the passed pos
		var space = get_world_2d().get_direct_space_state()
		var mousePos = get_viewport().get_mouse_pos()
		var results = space.intersect_point( mousePos, 32, [],\
		2147483647, Physics2DDirectSpaceState.TYPE_MASK_AREA )
		if (results.size() == 1):
			var revolver = get_parent().get_parent().get_node("Area2D")
			if (revolver.is_cocked()):
				revolver.fired()
				if (revolver.get_node(str("Barrel/Bullet", revolver.get_chamber())).is_visible()):
					print("Miss")
				else:
					print("No ammo")
			else:
				print("Cock gun")
		if (results.size() > 1):
			for i in range((results.size() - 1), -1, -1):
				print(results[i].collider.get_filename())
				if(results[i].values().has(self)):
					results.remove(i)
				elif(results[i].collider.has_method("is_hat")):
					results[i].collider.clicked()
			results[0].collider.clicked()