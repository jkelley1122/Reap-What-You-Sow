extends Area3D # In Godot, to detect triggers, we'll use an Area node.

@export var new_mat: Material # Equivalent to public Material in Unity

# Start
func _ready():
	pass
	
# OnTriggerEnter
func _on_body_entered(body: PhysicsBody3D): 
	if body.has_method("get_surface_material"): # Check if the body has a material we can change
		body.set_surface_material(0, new_mat)
