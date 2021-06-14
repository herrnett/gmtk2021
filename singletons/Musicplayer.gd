extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func crossfade(to):
	match to:
		1:
			$NeutralMusic.fade_in()
			$AngryMusic.fade_out()
			$HappyMusic.fade_out()
			$MotivatingMusic.fade_out()
		2:
			$NeutralMusic.fade_out()
			$AngryMusic.fade_in()
			$HappyMusic.fade_out()
			$MotivatingMusic.fade_out()
		3:
			$NeutralMusic.fade_out()
			$AngryMusic.fade_out()
			$HappyMusic.fade_in()
			$MotivatingMusic.fade_out()
		4:
			$NeutralMusic.fade_out()
			$AngryMusic.fade_out()
			$HappyMusic.fade_out()
			$MotivatingMusic.fade_in()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
