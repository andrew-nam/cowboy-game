extends Area2D

var cocked
var ammo
var chamber = 0 setget set_chamber, get_chamber
var health = 3 setget set_health, get_health

func _ready():
	cocked = false
	ammo = 6
	
func clicked():
	cocked = true
	print ("Cocked")
#func _input_event(viewport, event, shape_idx):
#	if event.type == InputEvent.MOUSE_BUTTON \
#	and event.button_index == BUTTON_LEFT \
#	and event.pressed:
#		cocked = true
#		print("Clicked")
		
func is_cocked():
	return cocked
	
func get_ammo():
	return ammo

func set_chamber():
	get_node("Barrel").set_rotd(get_rotd()-((chamber + 1) * 60))
	if(chamber == 5):
		chamber = 0
	else:
		chamber += 1

func get_chamber():
	return chamber

func fired():
	print(str("Bullet", get_chamber()))
	if(!get_node(str("Barrel/Bullet", get_chamber())).is_visible()):
		print("no ammo")
		cocked = false
		set_chamber()
	else:
		get_node(str("Barrel/Bullet", get_chamber())).set_hidden(true)
		cocked = false
		set_chamber()

func get_health():
	return health

func set_health(new):
	health = new