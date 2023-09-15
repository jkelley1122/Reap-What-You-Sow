extends Node3D

@export var plant_node: PackedScene
var plot_points: Array = []

func _process(delta):
	# Detect user input
	if Input.is_action_just_released("ui_select"):
		plot_points.append(global_transform.origin)
		
		if plot_points.size() == 2:
			def_plot()
			plot_points.clear()

func def_plot():
	var valid = true
	var nodes = get_tree().get_nodes_in_group("Planter") # Assuming all "Planter" nodes are in a group named "Planter"

	for point in plot_points:
		for n in nodes:
			if is_too_close(n.global_transform.origin, point):
				valid = false
				break

	if valid:
		define_plot_space()

func is_too_close(point1: Vector3, point2: Vector3) -> bool:
	return point1.distance_to(point2) < 0.75

func define_plot_space():
	var x = plot_points[0].x
	var step = 0.5
	
	while x != plot_points[1].x:
		var z = plot_points[0].z
		while z != plot_points[1].z:
			var new_plant = plant_node.instance()
			get_parent().add_child(new_plant)
			new_plant.global_transform.origin = Vector3(x, 0.05, z)
			z += step if plot_points[0].z < plot_points[1].z else -step
		x += step if plot_points[0].x < plot_points[1].x else -step
