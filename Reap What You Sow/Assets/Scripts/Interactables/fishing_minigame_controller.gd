extends Area3D

@onready var player = get_tree().current_scene.get_node("Player")
var random = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setup_fishing(area):
	# Currently the odds are
	# IF SANITY IS OVER 50:
	# 39% catch nothing
	# 30% catch bass
	# 20% catch carp
	# 10% catch trout
	# 1% catch golden fish
	# IF SANITY IS UNDER 50:
	# 90% catch nothing
	# 10% catch demon fish
	var rng = random.randi_range(0, 100)

	if player.sanity >= 50:
		if rng >= 0 && rng < 40:
			pass
		elif rng >= 40 && rng < 70:
			player.inventory.add_item("Bass", 1)  #adds bass to inventory
		elif rng >= 70 && rng < 90:
			player.inventory.add_item("Carp", 1)  #adds carp to inventory
		elif rng >= 90 && rng < 100:
			player.inventory.add_item("Salmon", 1)  #adds salmon to inventory
		elif rng == 100:
			player.inventory.add_item("Golden Fish", 1)  #adds rare golden fish to inventory
	elif player.sanity < 50:
		if rng >= 0 && rng < 90:
			pass
		elif rng >= 90 && rng <= 100:
			player.inventory.add_item("Demon Fish", 1)  #adds demon fish to inventory
#randi_range is indexed, in this case 0 - 4
