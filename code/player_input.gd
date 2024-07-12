extends Node2D

var input_delay = 200.0
var last_input_time = -input_delay

var parent
# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (last_input_time + input_delay < Time.get_ticks_msec()):
		if (Input.is_action_pressed("player_1_left")):
			var delay_time = parent.move("left")
			reset_time(delay_time)
		if (Input.is_action_pressed("player_1_right")):
			var delay_time = parent.move("right")
			reset_time(delay_time)
		if (Input.is_action_pressed("player_1_up")):
			var delay_time = parent.move("up")
			reset_time(delay_time)
		if (Input.is_action_pressed("player_1_down")):
			var delay_time = parent.move("down")
			reset_time(delay_time)

		if (Input.is_action_pressed("player_1_equip")):
			var delay_time = parent.equip("equip")
			reset_time(delay_time)

		if (Input.is_action_pressed("player_1_action_1")):
			var delay_time = parent.do_action("action_1")
			reset_time(delay_time)
		if (Input.is_action_pressed("player_1_action_2")):
			var delay_time = parent.do_action("action_2")
			reset_time(delay_time)
	pass

#resets player input timer
func reset_time(delay):
	if (delay == null):
		print("Invalid input")
	else:
		input_delay = delay
	
	last_input_time = Time.get_ticks_msec()
