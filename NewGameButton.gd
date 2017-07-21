extends Button

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	self.connect("pressed", self, "_on_newgame_pressed")

func _on_newgame_pressed():
	get_node("/root/global").goto_scene("res://Level.tscn")