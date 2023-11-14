extends Node3D

# @export is used to create in-editor variables like Unity's GameObject variable.
# PackedScene in Godot is similar to prefabs in Unity.
@export var plant_node: PackedScene

var croptype
var plot_points: Array = []
var plants: Array = []
var seeds_pouch

@onready var current_scene = get_tree().current_scene
@onready var player = get_tree().current_scene.get_node("Player")
@onready var HUD = get_tree().current_scene.get_node("Player").get_node("HUD")

func _ready():
	croptype = 0
	plants = ['Corn Seeds', 'Carrot Seeds', 'Blackberry Seeds', 'Raspberry Seeds', 'Tobacco Seeds', 'Broccoli Seeds', 'Wheat Seeds', 'Tomato Seeds', 'Cauliflower Seeds']
	
	seeds_pouch = current_scene.get_node("Player").get_node("SeedsPouch")
	
	# If the player is on the farm, load their existing planted crops
	if current_scene.name == "FarmScene":
		load_crops()
			
func _process(delta):
	# Detect user input (godot uses keybinds)
	if Input.is_action_just_released("ui_select") && current_scene.scene_file_path == "res://Assets/Scenes/FarmScene.tscn" && player.cur_item == "Hoe":
		# Adds the current position to the plot_points list.
		# global_transform.origin is similar to transform.position in Unity.
		plot_points.append(global_transform.origin)
		
		# If we have two plot points, we define the plot and then clear the points.
		if plot_points.size() == 2:
			def_plot()
			plot_points.clear()
	if Input.is_action_just_pressed("next_crop"):
		if croptype == len(plants)-1:
			croptype = 0
		else:
			croptype += 1
		GameController.player_crop = plants[croptype]

func def_plot():
	var valid = true
	# Godot allows you to group nodes and retrieve them. 
	# This is a feature similar to GameObject.FindGameObjectsWithTag("Planter") in Unity.
	var nodes = get_tree().get_nodes_in_group("Planter")

	for point in plot_points:
		for n in nodes:
			if is_too_close(n.global_transform.origin, point):
				valid = false
				break
			if does_overlap(n.global_transform.origin):
				valid = false
	if valid:
		define_plot_space()

# Checks the distance between two points to see if they are too close.
func is_too_close(point1: Vector3, point2: Vector3) -> bool:
	return point1.distance_to(point2) < 0.75 #initial version, allows placement of overlapping plots given suitable range from existing plots

func does_overlap(point1: Vector3) -> bool:
	var top = max(plot_points[0].z, plot_points[1].z)
	var bot = min(plot_points[0].z, plot_points[1].z)
	var left = min(plot_points[0].x, plot_points[1].x)
	var right = max(plot_points[0].x, plot_points[1].x)
	
	if point1.z <= top + 0.75 and point1.z >= bot - 0.75 and point1.x <= right + 0.75 and point1.x >= left - 0.75:
		return true
		
	else:
		return false
		
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
			if seeds_pouch.has_seed(plants[croptype], 1):
				var new_plant = plant_node.instantiate()
				
				get_tree().current_scene.add_child(new_plant)
				new_plant.global_transform.origin = Vector3(x, 0.05, z)
				new_plant.crop = croptype ############### New WIP shit #####################
				new_plant.time_planted = [GameController.time[0], GameController.time[1], GameController.time[2], GameController.time[3], GameController.time[4]]
				seeds_pouch.remove_seed(plants[croptype], 1)
				
				# Saves the crop so it is retained between scenes
				GameController.add_crop(new_plant.crop, new_plant.global_transform.origin, new_plant.time_planted)
			else:
				print("Not enough Seeds")
				break
			z += z_step
		x += x_step

###SCENE CHANGE FUNCTIONS###
# Loads crops from the list of crops kept in the game controller
func load_crops():
	for crop in GameController.crop_list:
		var time_planted = crop["time_planted"]
		var new_plant = plant_node.instantiate()
		
		# If this happens in the first frames, things go wrong, so we defer the call
		current_scene.call_deferred("add_child", new_plant)
		call_deferred("on_new_plant_added", new_plant, crop, time_planted)

# Continues work from load_crops(), is used to set up plant nodes with essential data. 
func on_new_plant_added(new_plant, crop, time_planted):
	new_plant.crop = crop["type"]
	new_plant.time_planted = time_planted
	new_plant.global_transform.origin = Vector3(crop["position"][0], crop["position"][1], crop["position"][2])

