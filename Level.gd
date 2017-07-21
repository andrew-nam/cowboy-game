extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var list_index = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
var list_reaction_time = []
var shot_count = 0 setget add_shot_count, get_shot_count
var time_previous = 0
var health = 3 setget set_health, get_health
var base setget get_base
var non_lethal_counter = 0 setget set_non_lethal, get_non_lethal
var lethal_counter = 0 setget set_lethal, get_lethal
onready var hit = get_node("Sprite")
var t = Timer.new()

func _ready():
	hit.hide()
	#determine reaction time
	
	self.add_child(t)
	
	var difficulty = get_node("/root/global").get_difficulty()
	
	#spawn enemy at index
	var scene = load("res://Enemy2.tscn")
	var scene_instance
	init_base_timer()
	while(shot_count < difficulty):
		scene_instance = scene.instance()
		scene_instance.set_z(-1)
		spawn_enemy(scene_instance)


func rand_index():
	randomize()
	#determine the section in which the enemy is spawned
	var section_index = (randi()%list_index.size())
	var index = list_index[section_index]
	list_index.remove(section_index)
	return index
		

func get_shot_count():
	return shot_count

func add_shot_count():
	shot_count += 1

func set_health(new):
	health = new
	if(health == 0):
		game_over()

func get_health():
	return health

func get_base():
	return base

func set_non_lethal(inc):
	non_lethal_counter += inc

func get_non_lethal():
	return non_lethal_counter

func set_lethal(inc):
	lethal_counter += inc

func get_lethal():
	return lethal_counter

func spawn_enemy(scene_instance):
	var time = set_reaction_time()
	time_previous = time
	var index = rand_index()
	add_child(scene_instance)
	scene_instance.initialize_enemy(index, time)
	scene_instance.add_to_group("enemies")
	scene_instance.connect("check_win", self, "win_cond")

func set_reaction_time():
	return (time_previous + rand_range(.3, .8))

func init_base_timer():
	base = rand_range(3, 5)
	var base_timer = Timer.new()
	base_timer.set_autostart(true)
	base_timer.set_one_shot(true)
	base_timer.set_wait_time(base)
	base_timer.connect("timeout", self, "on_base_timeout")
	add_child(base_timer)

func on_base_timeout():
	var draw = get_node("Draw/Draw")
	draw.connect("finished", self, "on_draw_finished")
	draw.play("draw")
	get_tree().call_group(0, "enemies", "start_reaction_time")

func on_draw_finished():
	get_node("Draw/Draw").stop(true)

func game_over():
	get_node("game_over").set_ignore_mouse(false)
	get_node("game_over").show()
	get_tree().set_pause(true)

func next_level():
	get_node("next_level").set_ignore_mouse(false)
	get_node("next_level").show()
	get_tree().set_pause(true)

func win_cond():
#	var t = Timer.new()
#	t.set_wait_time(.25)
#	t.set_one_shot(true)
#	self.add_child(t)
#	t.start()
#	yield(t, "timeout")
	wait(.25)
	yield(t, "timeout")
	if(!get_tree().get_nodes_in_group("enemies").size()):
		next_level()
		print(non_lethal_counter)
		print(lethal_counter)

func damage():
	set_health(get_health() - 1)
	print(get_health())
	hit.show()
	wait(.1)
	yield(t, "timeout")
	hit.hide()

func wait(time):
	print(time)
	t.set_wait_time(time)
	t.set_one_shot(true)
	t.start()
	
	