extends Button


func _ready():
	self.connect("pressed", self, "_on_return_pressed")

func _on_return_pressed():
	get_node("/root/global").goto_scene("res://Menu.tscn")
	get_tree().set_pause(false)
	get_node("/root/global").set_difficulty(1)