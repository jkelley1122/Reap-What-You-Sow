extends Area3D

@onready var player = get_tree().current_scene.get_node("Player")
var stop_movement = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	






func setup_fishing(area):
	if player.is_in_group("player"):
		player.inventory.add_item("Fish", 1)
		player.position.x = -3.289
		player.position.z = -0.991
