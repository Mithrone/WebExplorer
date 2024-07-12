#Controlls all player actions
extends AnimatableBody2D


var step_size = 200.0

var current_items = []
var equiped_items = []

var _collide

var team = "player"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
		#ACTIONS##################################################################
	
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
		if (collider.get_collider().get_groups().size() > 0):
			for group in collider.get_collider().get_groups():
				match group:
					"block":
						print("block collision")
					_:
						print("Not applicable collision")
		else:
			print("No Group collision")
		return 500


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



func move(action):
	var direction = ""
	
	#MOVEMENT###############################################
	if (action == "left"):
		_collide =  move_and_collide(Vector2(-step_size, 0))
		direction = "left"
		correct_position()
		collision(_collide, direction)
		return 200
	if (action == "right"):
		_collide =  move_and_collide(Vector2(step_size, 0))
		direction = "right"
		correct_position()
		collision(_collide, direction)
		return 200
	if (action == "up"):
		_collide =  move_and_collide(Vector2(0, -step_size))
		direction = "up"
		correct_position()
		collision(_collide, direction)
		return 200
	if (action == "down"):
		_collide =  move_and_collide(Vector2(0, step_size))
		direction = "down"
		correct_position()
		collision(_collide, direction)
		return 200

	#COLLISION AND MOVEMENT CORRECTION
	

func equip(action):
	if(action == "equip"):
		print(current_items)
		for item in current_items:
			print(item)
			if (item is Area2D):
				if (item.get_groups().size() > 0):
					for group in item.get_groups():
						match group:
							"equipable":
								if (item.get_parent() != self && equiped_items.size() < 1):
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
				
			else:
				print("NOT AREA2D")
				return null

		return 200
	else:
		return null
			

func do_action(action):
	if (equiped_items.size() > 0):
		if (action == "action_1"):
			var action_delay = equiped_items[0].do_action("action_1", team)
			return action_delay
		if (action == "action_2"):
			var action_delay = equiped_items[0].do_action("action_2", team)
			return action_delay