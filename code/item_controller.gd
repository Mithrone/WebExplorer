extends Area2D

var added = false
var last;

var item_sprite

var EQUIPED

# Called when the node enters the scene tree for the first time.
func _ready():
	item_sprite = get_child(0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var overlap = get_overlapping_bodies()
	EQUIPED = get_parent().is_in_group("player")
	var VALID_ADD_ITEM_TO_PLAYER = overlap.size() > 0 && !added
	var VALID_REMOVE_ITEM_FROM_PLAYER = overlap.size() <= 0 && added
	##TODO: Improve to be more general
	#Adds item to player 
	if (VALID_ADD_ITEM_TO_PLAYER):
		#A1
		overlap[0].add_items_to_list(self)
		last = overlap[0]
		added = true
	#Removes item from player
	elif (VALID_REMOVE_ITEM_FROM_PLAYER):
		if (last != null):
			last.remove_items_from_list(self)
		added = false
	
	if EQUIPED:
		item_sprite.modulate = Color(0, 0, 0, 0)
	else:
		item_sprite.modulate = Color(1, 1, 1, 1)
	pass

#Destroys this item
func destroy_item():
	var parent = self.get_parent()
	parent.remove_child(self)

#Adds this item to a parent (eg. Player Equip)
func equip_item(parent):
	var item = self
	item.get_parent().remove_child(item)
	parent.add_child(item)
	item.position = Vector2(0,0)

#Removes this item from a parent (eg. Player Unequip)
func unequip_item(parent):
	var item = self
	item.get_parent().remove_child(item)
	parent.get_parent().add_child(item)
	item.position = parent.position

#Does an action. Returns next action delay time
func do_action(action, _team):
		match action:
			"action_1":
				print("action 1")
				return 200
			_:
				print("invalid action")
				return null
