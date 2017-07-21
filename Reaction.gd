extends Timer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func set_reaction_time(time):
	set_autostart(false)
	set_one_shot(true)
	set_wait_time(time)
	connect("timeout", get_parent(), "on_timer_timeout")
