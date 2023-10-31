extends Area3D

@onready var player = get_tree().current_scene.get_node("Player")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	






func setup_fishing(area):
	if player.is_in_group("player"):         #trigger only when the player enters the trigger zone
		player.inventory.add_item("Fish", 1) #adds fish to inventory
		player.position.x = -3.289           #centers the player on the x and z axis.  temporary?
		player.position.z = -0.991
