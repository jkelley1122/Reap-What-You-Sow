extends Node3D

@export var scene_to_load = "FarmScene"


func _on_body_entered(body):
	var path_to_scene = "res://Assets/Scenes/" + scene_to_load + ".tscn"
	GameController.spawn_point = get_spawn()
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
