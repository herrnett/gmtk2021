extends Node2D

export(String, "Hammer", "Notebook", "Mask", "Nothing") var item_type

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var area = $Area2D
onready var sprite = $AnimatedSprite
onready var ani_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	reload()

func reload():
	match item_type:
		"Hammer":
			sprite.animation = "hammer"
		"Notebook":
			sprite.animation = "notebook"
		"Mask":
			sprite.animation = "mask"
		"Nothing":
			sprite.animation = "nothing"
		_:
			pass
	ani_player.play("move_item")
	yield()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
