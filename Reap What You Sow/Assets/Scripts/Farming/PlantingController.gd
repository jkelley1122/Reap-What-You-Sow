extends Area3D # In Godot, to detect triggers, we'll use an Area node.

@export var new_mat: Material # Equivalent to public Material in Unity

# Start
func _ready():
	pass
	
# OnTriggerEnter
# Look into signals in Godot if you want to better understand how this works.
func _on_body_entered(body: PhysicsBody3D): 
	get_parent().material_override = new_mat
