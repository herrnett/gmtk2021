extends Area2D

var id = "BreakableWall"
var type = "obstacle"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func smash():
	$StaticBody2D/CollisionShape2D.disabled = true
	$Sprite.visible = false
	$Sprite2.visible = false
	$CPUParticles2D.emitting = true
	$WallTimer.start(0.6)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_WallTimer_timeout():
	queue_free()
