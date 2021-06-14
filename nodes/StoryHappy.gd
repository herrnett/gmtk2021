extends Area2D

var type = "story"
var id = "StoryHappy"
var started = false

var text = [["DARN, TOO HIGH!", 2],
			["I can do it! Let me try!", 3],
			["THE HELL ARE YOU?!", 2],
			["Who are both of you?", 1],
			["SHUT UP!", 2],
			["I'll do it, John! It'll be fun!", 3]]

func returntext():
	return text



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
