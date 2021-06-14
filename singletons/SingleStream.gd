extends AudioStreamPlayer

onready var tween = get_node("Tween")

func fade_out():
	# tween music volume down to 0
	tween.interpolate_property(self, "volume_db", volume_db, -80, 0.6, Tween.TRANS_QUART, Tween.EASE_IN)
	tween.start()
	yield(tween, "tween_completed")

func fade_in():
	tween.interpolate_property(self, "volume_db", volume_db, 0, 0.6, Tween.TRANS_QUINT, Tween.EASE_OUT)
	tween.start()
	yield(tween, "tween_completed")
