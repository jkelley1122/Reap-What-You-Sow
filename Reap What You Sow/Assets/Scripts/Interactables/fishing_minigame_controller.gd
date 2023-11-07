extends Area3D

@onready var player = get_tree().current_scene.get_node("Player")
@onready var HUD = player.get_node("HUD")
var random = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setup_fishing(area):
	
	if player.is_in_group("player"):              #trigger only when the player enters the trigger zone
		var rng = random.randi_range(0, 3)        #you have a 1 in 3 chance of catching a fish currently. Temp?
		if rng == 1:
			player.inventory.add_item("Fish", 1)  #adds fish to inventory
			
	HUD.update_inventory_ui()
#randi_range is indexed, in this case 0 - 4
