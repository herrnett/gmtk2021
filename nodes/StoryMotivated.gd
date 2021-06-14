extends Area2D

var type = "story"
var id = "StoryMotivated"
var started = false

var john =  [["I guess I shouldn't touch the lasers.", 1],
			["YOU DONT SAY, BIGBRAIN!", 2],        
			["This looks very easy to me!", 4],
			["And who are you?", 1],
			["I trust you. Let her try, John!", 3],
			["What...?", 1]]

var angry = [["LASERS, THE ONE THING I CAN'T DESTROY!!", 2], 
			["There's probably more than that...",1 ],
			["Hey, John, listen! Hey! Let me try it!.",4 ],
			["You are so confident, I admire you.", 3],
			["What...?", 1]]

var happy = [["Wooah, such magnificent technology!",3 ],
			["Technology that kills me.",1 ],
			["I MISS THE SIMPLER TIMES!",2 ],
			["WHEN IT WAS JUST TWO MEN AND A CLUB.", 2],
			["It's a nice challenge, I will try it!", 4],
			["Nice to meet you!", 3],
			["What...?", 1]] 
			
var motivated = []


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
