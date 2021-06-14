extends Area2D

var type = "story"
var id = "StoryAbyss"
var started = false

var john = [["This looks dangerous.", 1],
				["Maybe there's another way.", 1]]
var angry = [["THAT FALL WILL DEFINITELY KILL US!", 2]]
var happy = [["What a view!", 3],
				["The people down there are so small!", 3]]
var motivated = [["Let's go somewhere else!", 4]]

func returntext():
	match Globals.personality:
		1:
			return john
		2:
			return angry
		3:
			return happy
		4:
			return motivated
		_:
			pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
