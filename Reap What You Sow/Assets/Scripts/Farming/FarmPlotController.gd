extends Node3D

# @export is used to create in-editor variables like Unity's GameObject variable.
# PackedScene in Godot is similar to prefabs in Unity.
@export var plant_node: PackedScene

var plot_points: Array = []

func _process(delta):
	# Detect user input (godot uses keybinds)
	if Input.is_action_just_released("ui_select"):
		# Adds the current position to the plot_points list.
		# global_transform.origin is similar to transform.position in Unity.
		plot_points.append(global_transform.origin)
		
		# If we have two plot points, we define the plot and then clear the points.
		if plot_points.size() == 2:
			def_plot()
			plot_points.clear()

func def_plot():
	var valid = true
	# Godot allows you to group nodes and retrieve them. 
	# This is a feature similar to GameObject.FindGameObjectsWithTag("Planter") in Unity.
	var nodes = get_tree().get_nodes_in_group("Planter")

	for point in plot_points:
		for n in nodes:
			if is_good_placement(n.global_transform.origin, point):
				valid = false
				break

	if valid:
		define_plot_space()

# Checks the distance between two points to see if they are too close.
#Also checks to make sure the plot is within the size constraints
func is_good_placement(point1: Vector3, point2: Vector3) -> bool:
	return point1.distance_to(point2) < 0.75

func define_plot_space():
	# Extract the start and end points for x and z.
	var x_start = plot_points[0].x
	var z_start = plot_points[0].z
	var x_end = plot_points[1].x
	var z_end = plot_points[1].z

	# Determine the step direction based on the relative positions.
	# In Godot, you can use ternary conditions just like in C#.
	var x_step = 0.5 if x_start < x_end else -0.5
	var z_step = 0.5 if z_start < z_end else -0.5

	var x = x_start
	while (x_step > 0 and x <= x_end) or (x_step < 0 and x >= x_end):
		var z = z_start
		while (z_step > 0 and z <= z_end) or (z_step < 0 and z >= z_end):
			# Instantiate a new plant node.
			# This is equivalent to Unity's Instantiate function.
			var new_plant = plant_node.instantiate()
			get_tree().current_scene.add_child(new_plant)
			new_plant.global_transform.origin = Vector3(x, 0.05, z)
			z += z_step
		x += x_step
