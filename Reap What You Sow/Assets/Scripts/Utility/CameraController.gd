extends Camera3D

@export var player: Node3D # Drag and drop the player node in the inspector to this variable
@export var offset = Vector3(0, 0, 0) # Adjust this to your needs

func _physics_process(delta):
	if player:
		global_transform.origin = player.global_transform.origin + offset
