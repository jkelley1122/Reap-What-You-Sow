extends Area3D

@export var scene_to_load = "FarmScene"
var path_to_scene = "res://Assets/Scenes/" + scene_to_load + ".tscn"

func _on_body_entered(body):
	path_to_scene = "res://Assets/Scenes/" + scene_to_load + ".tscn"
	if body.is_in_group("player"):
		get_tree().change_scene_to_file(path_to_scene)
