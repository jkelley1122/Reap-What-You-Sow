extends Node3D

@export var scene_to_load = "FarmScene"


func _on_body_entered(body):
	var path_to_scene = "res://Assets/Scenes/" + scene_to_load + ".tscn"
	GameController.spawn_point = get_spawn()
	GameController.time = get_time()
	if body.is_in_group("player"):
		get_tree().change_scene_to_file(path_to_scene)
		GameController.call_deferred("change_scene")

func get_spawn():
	# Get the full path of the current scene: "res://scenes/FarmScene.tscn"
	var full_name = get_tree().get_current_scene().name
	# Remove the last 5 characters (i.e., "Scene"): "Farm"
	var scene_name = full_name.substr(0, full_name.length() - 5)
	
	var spawn = "From" + scene_name
	
	return spawn
	
func get_time():
	var timer = get_tree().get_current_scene().get_node("Utility").get_node("Timer")
	var time_values = [0, 0, 0, 0, 0]
	time_values[0] = timer.seconds
	time_values[1] = timer.minutes
	time_values[2] = timer.days
	time_values[3] = timer.months
	time_values[4] = timer.years
	
	return time_values
