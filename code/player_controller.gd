#Controlls all player actions
extends AnimatableBody2D

var input_delay = 200.0
var last_input_time = -input_delay
var step_size = 200.0

var current_items = [];

# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (last_input_time + input_delay < Time.get_ticks_msec()):
		var _collide
		if (Input.is_action_pressed("player_1_left")):
			_collide =  move_and_collide(Vector2(-step_size, 0))
			last_input_time = Time.get_ticks_msec()
		if (Input.is_action_pressed("player_1_right")):
			_collide =  move_and_collide(Vector2(step_size, 0))
			last_input_time = Time.get_ticks_msec()
		if (Input.is_action_pressed("player_1_up")):
			_collide =  move_and_collide(Vector2(0, -step_size))
			last_input_time = Time.get_ticks_msec()
		if (Input.is_action_pressed("player_1_down")):
			_collide =  move_and_collide(Vector2(0, step_size))
			last_input_time = Time.get_ticks_msec()

		correct_position()

		if (_collide is KinematicCollision2D):
			print(_collide.get_collider())
		
	pass

#Corrects the position to the nearest step. Currently it is every 200th pixel sideways and vertically
func correct_position():
	if (abs(fmod(position.x, step_size)) > (step_size / 2)):
		position.x = position.x - (abs(fmod(position.x, step_size)) - step_size)
	else:
		position.x = position.x - abs(fmod(position.x, step_size))

	if (fmod(position.y, step_size) < 0):
		if (abs(fmod(position.y, step_size) + step_size) > (step_size / 2)):
			position.y = position.y - (abs(fmod(position.y, step_size)) - step_size)
		else:
			position.y = position.y - abs(fmod(position.y, step_size) + step_size)
	else:
		if (abs(fmod(position.y, step_size)) > (step_size / 2)):
			position.y = position.y - (abs(fmod(position.y, step_size)) - step_size)
		else:
			position.y = position.y - abs(fmod(position.y, step_size))

func add_items_to_list(item):
	current_items.append(item)
	print(current_items)

func remove_items_to_list(item):
	current_items.erase(item)
	print(current_items)
