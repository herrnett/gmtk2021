extends Area2D

var id = "Blinkenlights"
var type = "obstacle"

var door_open = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func execute():
	if ((Globals.item_e == "notebook" and Globals.item_q == "mask")
	or (Globals.item_e == "mask" and Globals.item_q == "notebook")):
		if ((Globals.personality == 3 or Globals.personality == 4)
		and !door_open):
			$AnimationPlayer.play("open_door")
			door_open = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
