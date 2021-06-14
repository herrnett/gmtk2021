extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.stop(true)
	$Logo.frame = 0
	$Logo.play()


func _process(delta):
	if Input.is_action_just_pressed("ui_accept") and !$AnimationPlayer.is_playing():
		SceneChanger.change_scene("res://nodes/Game.tscn", true)


func _on_Logo_animation_finished():
	$AnimationPlayer.play("FadeLogo")
