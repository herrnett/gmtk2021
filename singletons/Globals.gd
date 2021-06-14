extends Node

var time_stop = false
var initial_sanity = 200.0
var switchloss_amount = 10

var personality = 1
var current_sanity = initial_sanity
var item_e = "Hammer"
var item_q = "Nothing"
var item_x = "Nothing"

## DELETE ME LATER ##
var has_angry = true
var has_happy = true
var has_motivated = true

#var has_angry = false
#var has_happy = false
#var has_motivated = false

# return value used for visualization
func sanityloss():
	match personality:
		1: # Neutral
			current_sanity -= 1
			return 1
		2: # Angry
			current_sanity -= 2
			return 2
		3: # Happy
			current_sanity -= 2
			return 2
		4: # Motivated
			current_sanity -= 2
			return 2

func switchloss():
	current_sanity -= switchloss_amount
	return switchloss_amount

func sanitypercent():
	return -current_sanity/initial_sanity

func reset():
	personality = 1
	current_sanity = initial_sanity
	item_e = "Nothing"
	item_q = "Nothing"
	has_angry = false
	has_happy = false
	has_motivated = false
	
