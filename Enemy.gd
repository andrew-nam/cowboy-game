extends Node2D

#class members
var x setget set_x, get_x
var y setget set_y, get_y
const Y_OFFSET = 2048
var scale setget set_scale, get_scale
var flags = [false, false, false] setget set_flags, get_flags
var reaction_time
var reload_counter = 0
var reaction_timer
signal check_win

func set_x(section_index):
	if(section_index < 3):
		x = (section_index * 480) + 240
	elif(section_index >= 3 and section_index < 7):
		x = ((section_index - 3) * 360) + 180
	else:
		x = ((section_index - 7) * 288) + 144

func get_x():
	return x

func set_y(section_index):
	if(section_index < 3):
		y = (Y_OFFSET - 870) + 435
	elif(section_index >= 3 and section_index < 7):
		y = (Y_OFFSET - 870 - 650) + 325
	else:
		y = (Y_OFFSET - 870 - 650 - 520) + 260

func get_y():
	return y

func set_scale(section_index):
	if(section_index < 3):
		scale = Vector2(3,3)
	elif(section_index >= 3 and section_index < 7):
		scale = Vector2(2.4, 2.4)
	else:
		scale = Vector2(1.9, 1.9)

func get_scale():
	return scale

func set_flags(selector):
	flags[selector] = true

func get_flags():
	for n in flags:
		return n

func start_reaction_time():
	get_node("Timer").start()

func initialize_enemy(section_index, time):
	#initialize position and scale variables
	#derive x,y position based on index
	set_x(section_index)
	set_y(section_index)
	set_scale(section_index)
	#increment shot count of level
	var parent = get_tree().get_root().get_node("Level")
	parent.add_shot_count()
	#if shotcount is still below the shots required of the difficulty,
	#test for flags, tested_flags contains flags that have been tested
	#for turning on or not
	initialize_flags(parent)
	
	#set position and scale of enemy instance
	translate(Vector2(x, y))
	scale(scale)
	
	#set reaction time
	get_node("Timer").set_reaction_time(time)
	reaction_time = time
	
	var specialization = [get_node("body").get_node("torso").get_func(), get_node("head").get_func(),\
	 get_node("legs").get_func()]
	set_specialization(specialization)
	twitch()

func initialize_flags(parent):
	#initialize_flags determines specialities of enemies, if any. Enemy
	#specialties are determined by the state of a boolean var in an array
	#initialize_flags tests randomly selects the first flag to test
	#this allows all specialties an equal chance of being picked if 
	#there is only one shot left. The state of the specialty is then randomly
	#determined, and the shot added accordingly.
	var selector
	var flags_remaining = [0, 1, 2]
	while(flags_remaining.size() > 0):
		selector = ((randi()%flags_remaining.size()))
		if(parent.get_shot_count() < get_node("/root/global").get_difficulty()):
		#test to see if flag has been tested already, if not add to array
			#test to see if the specialization will be turned on
			if(randi()%3 < 2):
				set_flags(flags_remaining[selector])
				parent.add_shot_count()
		else:
			return
		flags_remaining.remove(selector)

func set_specialization(specialization):
	#Visual indicators of specialization must be present in the sprites
	#displayed on screen. This function randomly selects the sprite to be 
	#loaded representing the corresponding specialization.
	var n = 0
	while(n < 3):
		if(flags[n]):
			var rand = (randi()%specialization.size())
			specialization[rand].call_func(n)
			specialization.remove(rand)
			if(n == 0):
				get_node("body").set_dynamite()
			if(n == 1):
				get_node("head").set_courage()
			if(n == 2):
				get_node("body").get_node("torso").set_armor()
		n += 1

func twitch():
	var twitch_timer = Timer.new()
	twitch_timer.set_autostart(true)
	twitch_timer.set_one_shot(true)
	twitch_timer.set_wait_time(rand_range(1, get_parent().get_base()))
	twitch_timer.connect("timeout", self, "on_twitch_timeout")
	add_child(twitch_timer)

func draw():
		#draw animation
	var body_flags = get_node("body/torso").body_flags
	var anim_name = "gun_draw"
	
	if(get_node("body").get_l_handedness()):
		var draw_anim = get_node("body/arm_l/draw")
		anim_name += "_l"
		if(body_flags[0]):
			anim_name += "_r"
		elif(body_flags[1]):
			anim_name += "_g"
		elif(body_flags[2]):
			anim_name += "_b"
		draw_anim.play(anim_name)
		
	else:
		var draw_anim = get_node("body/arm_r/draw")
		anim_name += "_r"
		if(body_flags[0]):
			anim_name += "_r"
		elif(body_flags[1]):
			anim_name += "_g"
		elif(body_flags[2]):
			anim_name += "_b"
		draw_anim.play(anim_name)

func non_lethal_anim():
	var body_flags = get_node("body/torso").get_body_flags()
	var non_lethal = get_node("non_lethal_anim")
	var anim_name = "non_lethal"
	non_lethal.connect("finished", self, "on_death_finished")
	
	if(body_flags[0]):
		anim_name += "_r"
	elif(body_flags[1]):
		anim_name += "_g"
	elif(body_flags[2]):
		anim_name += "_b"
	else:
		anim_name += "_n"
	
	non_lethal.play(anim_name)

func lethal_anim():
	var body_flags = get_node("body/torso").get_body_flags()
	var legs_flags = get_node("legs").get_legs_flags()
	var death_anim = get_node("death_anim")
	var anim_name = "lethal_"
	death_anim.connect("finished", self, "on_death_finished")
	
	if(legs_flags[0]):
		anim_name += "r_"
	elif(legs_flags[1]):
		anim_name += "g_"
	elif(legs_flags[2]):
		anim_name += "b_"
	else:
		anim_name += "n_"
	if(body_flags[0]):
		anim_name += "r"
	elif(body_flags[1]):
		anim_name += "g"
	elif(body_flags[2]):
		anim_name += "b"
	else:
		anim_name += "n"
	
	death_anim.play(anim_name)

func on_death_finished():
	kill()

func on_timer_timeout():
	draw()
	reaction_timer = Timer.new()
	reaction_timer.set_autostart(false)
	reaction_timer.set_one_shot(true)
	reaction_timer.connect("timeout", self, "on_reaction_timeout")
	add_child(reaction_timer)
	
	print(self, " bang ", reload_counter)
	get_node("body").shot()
	reload_counter += 1
	reaction_timer.start()
	
	
func on_reaction_timeout():
	if(reload_counter < 6):
		print(self, " bang ", reload_counter)
		get_node("body").shot()
		reload_counter += 1
		if(reload_counter == 6):
			print("reloading")
			reaction_timer.set_wait_time(6 * reaction_time)
		reaction_timer.start()
	elif(reload_counter == 6):
		reload_counter = 0
		reaction_timer.set_wait_time(reaction_time)
		reaction_timer.start()

func on_twitch_timeout():
	if(get_node("body").get_l_handedness()):
		get_node("body/arm_l/twitch_l").play("twitch_l")
	else:
		get_node("body/arm_r/twitch_r").play("twitch_r")

func non_lethal():
	get_parent().set_non_lethal(1)
	non_lethal_anim()

func lethal():
	get_parent().set_lethal(1)
	lethal_anim()

func kill():
	print(self)
	self.queue_free()
	emit_signal("check_win")
