extends Area2D

var added = false
var last;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var overlap = get_overlapping_bodies()
	##TODO: Improve to be more general
	#Adds item to player 
	if (overlap.size() > 0 && !added):
		overlap[0].add_items_to_list(self)
		last = overlap[0]
		added = true
	#Removes item from player
	elif (overlap.size() <= 0 && added):
		if (last != null):
			last.remove_items_to_list(self)
		added = false
	pass
