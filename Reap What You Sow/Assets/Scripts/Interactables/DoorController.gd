extends StaticBody3D

@export var scene_to_load = "FarmScene"

# Called when the node enters the scene tree for the first time.
func open():
	var path_to_scene = "res://Assets/Scenes/" + scene_to_load + ".tscn"
	get_tree().change_scene_to_file(path_to_scene)
