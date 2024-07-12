#Controlls all player actions
extends AnimatableBody2D

var input_delay = 200.0
var last_input_time = -input_delay
var step_size = 200.0

var current_items = []
var equiped_items = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (last_input_time + input_delay < Time.get_ticks_msec()):
		var _collide
		var direction = ""

		#MOVEMENT###############################################
		if (Input.is_action_pressed("player_1_left")):
			_collide =  move_and_collide(Vector2(-step_size, 0))
			reset_time(200)
			direction = "left"
		if (Input.is_action_pressed("player_1_right")):
			_collide =  move_and_collide(Vector2(step_size, 0))
			reset_time(200)
			direction = "right"
		if (Input.is_action_pressed("player_1_up")):
			_collide =  move_and_collide(Vector2(0, -step_size))
			reset_time(200)
			direction = "up"
		if (Input.is_action_pressed("player_1_down")):
			_collide =  move_and_collide(Vector2(0, step_size))
			reset_time(200)
			direction = "down"

		#COLLISION AND MOVEMENT CORRECTION
		correct_position()
		collision(_collide, direction)

		#EQUIP################################################################
		if(Input.is_action_pressed("player_1_equip")):
			for item in current_items:
				if (item is Area2D):
					if (item.get_groups().size() > 0):
						for group in item.get_groups():
							match group:
								"equipable":
									if (item.get_parent() != self && equiped_items.size() < 1):
										#A3
										# add
										item.equip_item(self)
										equiped_items.append(item)
									else:
										# remove
										item.unequip_item(self)
										equiped_items.erase(item)
								_:
									print("Unknown item group")
					else:
						print("No item group")

					reset_time(200)
				else:
					print("NOT AREA2D")
				pass

		#ACTIONS##################################################################
		if (equiped_items.size() > 0):
			if (Input.is_action_pressed("player_1_action_1")):
				var action_delay = equiped_items[0].do_action("action_1", "player")
				reset_time(action_delay)
			if (Input.is_action_pressed("player_1_action_2")):
				var action_delay = equiped_items[0].do_action("action_2", "player")
				reset_time(action_delay)
	pass

#Corrects the position to the nearest step. Currently it is every 200th pixel sideways and vertically
func correct_position():
	if (fmod(position.x, step_size) < 0):
		if (abs(fmod(position.x, step_size) + step_size) > (step_size / 2)):
			position.x = position.x - (abs(fmod(position.x, step_size) + step_size) - step_size)
		else:
			position.x = position.x - abs(fmod(position.x, step_size) + step_size)
	elif (fmod(position.x, step_size) > 0):
		if (abs(fmod(position.x, step_size)) > (step_size / 2)):
			position.x = position.x - (abs(fmod(position.x, step_size)) - step_size)
		else:
			position.x = position.x - abs(fmod(position.x, step_size))

	if (fmod(position.y, step_size) < 0):
		if (abs(fmod(position.y, step_size) + step_size) > (step_size / 2)):
			position.y = position.y - (abs(fmod(position.y, step_size) + step_size) - step_size)
		else:
			position.y = position.y - abs(fmod(position.y, step_size) + step_size)
	elif (fmod(position.y, step_size) > 0):
		if (abs(fmod(position.y, step_size)) > (step_size / 2)):
			position.y = position.y - (abs(fmod(position.y, step_size)) - step_size)
		else:
			position.y = position.y - abs(fmod(position.y, step_size))

#Handles collision with different nodes
func collision(collider, _direction):
	if (collider is KinematicCollision2D):
		reset_time(500)
		if (collider.get_collider().get_groups().size() > 0):
			for group in collider.get_collider().get_groups():
				match group:
					"block":
						print("block collision")
					_:
						print("Not applicable collision")
		else:
			print("No Group collision")


#add items to a list
func add_items_to_list(item):
	#A2
	if (item.is_in_group("destructable")):
		#handle item
		print("handle item destroy")
		#destroy
		item.destroy_item()
	else:
		current_items.append(item)
	

#removes an item from the list
func remove_items_from_list(item):
	current_items.erase(item)

#resets player input timer
func reset_time(delay):
	last_input_time = Time.get_ticks_msec()
	input_delay = delay
