extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Indicators/Angry.visible = Globals.has_angry
	$Indicators/Happy.visible = Globals.has_happy
	$Indicators/Motivated.visible = Globals.has_motivated

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	$ItemE.animation = Globals.item_e
	$ItemQ.animation = Globals.item_q
	
	if ((Globals.item_e == "Notebook" and Globals.item_q == "Mask")
	or (Globals.item_e == "Mask" and Globals.item_q == "Notebook")):
		Globals.item_x == "Hacking"
		$ItemX.visible = true
		$Fuse.visible = true
		$Fuse/AnimationPlayer.play("blink")
	else:
		Globals.item_x == "Nothing"
		$ItemX.visible = false
		$Fuse.visible = false
		$Fuse/AnimationPlayer.stop()
	
	if !$Indicators/Angry.visible and Globals.has_angry: $Indicators/Angry.visible = true
	if !$Indicators/Happy.visible and Globals.has_happy: $Indicators/Happy.visible = true
	if !$Indicators/Motivated.visible and Globals.has_motivated: $Indicators/Motivated.visible = true
	
	match Globals.personality:
		1: #neutral
			$Indicators/Neutral.frame = 1
			$Indicators/Angry.frame = 2
			$Indicators/Happy.frame = 4
			$Indicators/Motivated.frame = 6
		2: #angry
			$Indicators/Neutral.frame = 0
			$Indicators/Angry.frame = 3
			$Indicators/Happy.frame = 4
			$Indicators/Motivated.frame = 6
		3: #happy
			$Indicators/Neutral.frame = 0
			$Indicators/Angry.frame = 2
			$Indicators/Happy.frame = 5
			$Indicators/Motivated.frame = 6
		4: #motivated
			$Indicators/Neutral.frame = 0
			$Indicators/Angry.frame = 2
			$Indicators/Happy.frame = 4
			$Indicators/Motivated.frame = 7

func animate_sanity(loss):
	$SanityLoss.bbcode_text = "[center]-" + str(loss) + "[/center]"
	$SanityLoss/AnimationPlayer.play("san_loss_ani")
	$Sanity.rect_scale.y = Globals.sanitypercent()

func perform_switchloss():
	$SwitchLoss.bbcode_text = "[center][color=#BE1212]-" + str(Globals.switchloss()) + "[/color][/center]"
	$SwitchLoss/AnimationPlayer.play("san_loss_ani")
	$Sanity/AnimationPlayer.play("sanity_loss")
	$Sanity.rect_scale.y = Globals.sanitypercent()

func _on_Timer_timeout():
	if Globals.has_angry and !Globals.time_stop:
		animate_sanity(Globals.sanityloss())
