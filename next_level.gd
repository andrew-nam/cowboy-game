extends Button

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	self.connect("pressed", self, "_on_next_level_pressed")

func _on_next_level_pressed():
	print("pressed")
	get_node("/root/global").set_difficulty(get_node("/root/global").get_difficulty() + 1)
	get_node("/root/global").goto_scene("res://Level.tscn")
	#get_tree().reload_current_scene()
	get_tree().set_pause(false)