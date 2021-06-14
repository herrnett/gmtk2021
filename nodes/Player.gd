extends KinematicBody2D

const TARGET_FPS = 60
const GRAVITY = 8
const FRICTION = 20
var acceleration = 8
var maxspeed = 64
var jumppower = 160
var maxjumps = 1
var jumpcount = 0


var motion = Vector2.ZERO

onready var sprite = $AnimatedSprite


### Storyzeug ###
var angertext = [["Oh, a hammer.", 1], 
				["Use it!", 2], 
				["Wait, who's this?", 1],
				["USE IT!", 2],
				["How?", 1],
				["HAVE YOU NEVER USED A HAMMER?!", 2],
				["Yes, but...", 1],
				["NO BUTS! GO AND SMASH SOMETHING!", 2],
				["But why?", 1],
				["SCREW IT, I'LL DO IT MYSELF!", 2]]
var firstreturn = true
var firstreturntext = [["What was that...?", 1],
						["My head hurts...", 1],
						["I should probably leave this place.", 1]]
var currenttext = []
var currentarea = null


# Called when the node enters the scene tree for the first time.
func _ready():
	MusicPlayer.crossfade(Globals.personality)
	match Globals.personality:
		1: # Neutral
			sprite.animation = "neutral_stand"
		2: # Angry
			sprite.animation = "angry_stand"
		3: # Happy
			sprite.animation = "happy_stand"
		4: # Motivated
			sprite.animation = "motivated_stand"



func _physics_process(delta):
	### ADJUSTMENTS ###
	# Check for current personality, adjust values
	match Globals.personality:
		1: # Neutral
			acceleration = 8
			maxspeed = 120
			maxjumps = 0
		2: # Angry
			acceleration = 8
			maxspeed = 80
			maxjumps = 1
		3: # Happy
			acceleration = 8
			maxspeed = 120
			maxjumps = 2
		4: # Motivated
			acceleration = 14
			maxspeed = 200
			maxjumps = 1

	
	## DEALING WITH INPUT ##
	# Deal with ui_accept when time is frozen (for cutscenes)
	if Globals.time_stop:
		if (Input.is_action_just_pressed("ui_accept")
		or Input.is_action_just_pressed("ui_e")
		or Input.is_action_just_pressed("ui_q")):
			dialogue(currenttext, currentarea)
	
	# Deal with all input during the rest of the game
	else:
		# Switch personalities on number keys
		if (Input.is_action_just_pressed("ui_neutral") 
		and Globals.personality != 1): 
			switch_personality(1)
			if firstreturn:
				currenttext = firstreturntext
				dialogue(currenttext)
			else:
				set_label("I feel sick...")
				$PlayerTimer.start(1)
				yield($PlayerTimer, "timeout")
				unset_label()
		if (Input.is_action_just_pressed("ui_angry") 
		and Globals.has_angry  
		and Globals.personality !=2): 
			switch_personality(2)
		if (Input.is_action_just_pressed("ui_happy") 
		and Globals.has_happy
		and Globals.personality !=3): 
			switch_personality(3)
		if (Input.is_action_just_pressed("ui_motivated") 
		and Globals.has_motivated
		and Globals.personality !=4): 
			switch_personality(4)
		
		# Picking up/using items
		if Input.is_action_just_pressed("ui_e"):
			for area in $Area2D.get_overlapping_areas():
				$AudioStreamPlayer.play()
				if Globals.item_e == "Nothing" and area.get("type") == null:
					Globals.item_e = area.get_node("..").item_type
					area.get_node("..").item_type = "Nothing"
					area.get_node("..").reload()
#					set_label(area) Too fast or sth.
					#Start the first encounter
					if !Globals.has_angry:
						currenttext = angertext
						dialogue(currenttext)
				elif area.get("type") != null:
					match area.get("id"):
						"BreakableWall": # Smash the Wall!
							if Globals.personality == 2 and Globals.item_e == "Hammer":
								set_label("[color=#BE1212]BERLIN SMASH!!![/color]")
								area.smash()
						_: pass
				# Check for area type, check if has execute and go for it
#				elif area.get("type") != null:
#					if area.has_method("execute"): area.execute()
				else:
					if area.get_node("..").get("item_type") != null:
						var temp = Globals.item_e
						Globals.item_e = area.get_node("..").item_type
						area.get_node("..").item_type = temp
						area.get_node("..").reload()
	#					set_label(area)
		if Input.is_action_just_pressed("ui_q"):
			for area in $Area2D.get_overlapping_areas():
				$AudioStreamPlayer.play()
				if Globals.item_q == "Nothing" and area.get("type") == null:
					Globals.item_q = area.get_node("..").item_type
					area.get_node("..").item_type = "Nothing"
					area.get_node("..").reload()
#					set_label(area)
					#Start the first encounter
					if !Globals.has_angry:
						currenttext = angertext
						dialogue(currenttext)
				# Smash the Wall!
				elif area.get("type") != null:
					match area.get("id"):
						"BreakableWall": # Smash the Wall!
							if Globals.personality == 2 and Globals.item_q == "Hammer":
								set_label("[color=#BE1212]BERLIN SMASH!!![/color]")
								area.smash()
						_: pass
				# Check for area type, check if has execute and go for it
#				elif area.get("type") != null:
#					if area.has_method("execute"): area.execute()
				else:
					if area.get_node("..").get("item_type") != null:
						var temp = Globals.item_q
						Globals.item_q = area.get_node("..").item_type
						area.get_node("..").item_type = temp
						area.get_node("..").reload()
	#					set_label(area)
		if Input.is_action_just_pressed("ui_x"):
			for area in $Area2D.get_overlapping_areas():
				$AudioStreamPlayer.play()
				if area.has_method("execute"): 
					area.execute()
				#WIN CONDITION
					Globals.time_stop = true
					$PlayerTimer.start(1)
					yield($PlayerTimer, "timeout")
					SceneChanger.change_scene("res://nodes/Victory.tscn", true)
					
		
		## MOVEMENT ##
		# THIS BORROWS HEAVILY FROM HEARTBEAST, WHO'S VIDEOS
		# CONVINCED ME TO TRY GODOT IN THE FIRST PLACE.
		# SERIOUSLY, LOOK AT HIS STUFF, HE'S AWESOME.
		var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")

		# Walking and it's animations
		if x_input != 0:
			match Globals.personality:
				1: # Neutral
					sprite.animation = "neutral_walk"
				2: # Angry
					sprite.animation = "angry_walk"
				3: # Happy
					sprite.animation = "happy_walk"
				4: # Motivated
					sprite.animation = "motivated_walk"
			motion.x += x_input * acceleration * delta * TARGET_FPS
			motion.x = clamp(motion.x, -maxspeed, maxspeed)
			sprite.flip_h = x_input < 0
		else:
			match Globals.personality:
				1: # Neutral
					sprite.animation = "neutral_stand"
				2: # Angry
					sprite.animation = "angry_stand"
				3: # Happy
					sprite.animation = "happy_stand"
				4: # Motivated
					sprite.animation = "motivated_stand"

		# Falling
		motion.y += GRAVITY * delta * TARGET_FPS

		if is_on_floor():
			jumpcount = 0
			if x_input == 0:
				motion.x = lerp(motion.x, 0, FRICTION * delta)

			if Input.is_action_just_pressed("ui_up") and maxjumps != 0:
				motion.y = -jumppower
				jumpcount += 1
		else:
			match Globals.personality:
					1: # Neutral
						sprite.animation = "neutral_jump"
					2: # Angry
						sprite.animation = "angry_jump"
					3: # Happy
						sprite.animation = "happy_jump"
					4: # Motivated
						sprite.animation = "motivated_jump"
			
			if Input.is_action_just_pressed("ui_up") and jumpcount < maxjumps:
				motion.y = -jumppower
				jumpcount += 1

			if Input.is_action_just_released("ui_up") and motion.y < -jumppower/2:
				motion.y = -jumppower/2

			if x_input == 0:
				motion.x = lerp(motion.x, 0, delta)

		motion = move_and_slide(motion, Vector2.UP)
	
	if Globals.current_sanity <= 0:
		die()

func dialogue(textarray, area = null):
	#Legacy-approach, fix later
	if area == null:
		Globals.time_stop = true
		var currentline = textarray.pop_front() 
		# pop_front is slower than pop_back because it basically reorders and pops the back
		# everytime. Maybe reorder manually and use pop_back.
		if currentline == null:
			unset_label()
			Globals.time_stop = false
			if !Globals.has_angry:
				Globals.has_angry = true
				switch_personality(2)
		else:
			match currentline[1]:
				1:
					set_label("[color=#DBDBDB]%s[/color]" % currentline[0])
				2:
					set_label("[color=#BE1212]%s[/color]" % currentline[0])
				3:
					set_label("[color=#6ABE30]%s[/color]" % currentline[0])
				4:
					set_label("[color=#FBF236]%s[/color]" % currentline[0])
	# new approach
	else:
		match area.id:
			"StoryHappy": # happy joins (story_happy.gd)
				if !area.started:
					$PlayerTimer.start(0.8)
					yield($PlayerTimer, "timeout")
					area.started = true
				if talk(textarray) == "done":
					Globals.has_happy = true
					switch_personality(3)
					area.queue_free()
					currentarea = null
			"StoryAbyss": # looking into the abyss
				if !area.started:
					#put things here to do stuff before the talking
					area.started = true
				if talk(textarray) == "done":
					area.queue_free()
					currentarea = null
			"StoryMotivated":
				if !area.started:
					#put things here to do stuff before the talking
					area.started = true
				if talk(textarray) == "done":
					Globals.has_motivated = true
					switch_personality(4)
					area.queue_free()
					currentarea = null
			_:
				pass
		
		
		

func talk(textarray):
	Globals.time_stop = true
	var currentline = textarray.pop_front() 
	# pop_front is slower than pop_back because it basically reorders and pops the back
	# everytime. Maybe reorder manually and use pop_back.
	if currentline == null:
		unset_label()
		Globals.time_stop = false
		return "done"
	else:
		match currentline[1]:
			1:
				set_label("[color=#DBDBDB]%s[/color]" % currentline[0])
			2:
				set_label("[color=#BE1212]%s[/color]" % currentline[0])
			3:
				set_label("[color=#6ABE30]%s[/color]" % currentline[0])
			4:
				set_label("[color=#FBF236]%s[/color]" % currentline[0])

func die():
	Globals.reset()
	get_tree().reload_current_scene()

func switch_personality(n):
	Globals.personality = n
	if n != 1: $CanvasLayer/Overlay.perform_switchloss()
	MusicPlayer.crossfade(n)

func set_label(text):
	$PlayerLabel.bbcode_text = "[center]%s[/center]" % text

func unset_label():
	$PlayerLabel.bbcode_text = ""

func _on_Area2D_area_entered(area):
	#check for variable "id" to identify story areas
	if area.get("id") != null:
		if area.type == "story":
			currentarea = area
			currenttext = area.returntext() 
			#change breakable wall to sth. with an id later to make this here the standard approach?
			#indicator for what should be done after dialogue is done used in dialogue
			dialogue(currenttext, currentarea)
		elif area.type == "obstacle":
			set_label("???")
	elif area.get_node("..").get("item_type") != null:
		if (area.get_node("..").get("item_type") == "Nothing"
		and (Globals.item_e != "Nothing" or Globals.item_q != "Nothing")):
			set_label("Put sth. here?")
		else: set_label(area.get_node("..").item_type)
	else: pass

func _on_Area2D_area_exited(_area):
	unset_label()


func _on_Killplane_body_entered(body):
	if body == self: die()


func _on_Area2D_body_entered(body):
	if body == self: die()
