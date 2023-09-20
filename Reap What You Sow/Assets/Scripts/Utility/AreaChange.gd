extends Area3D

@export var scene_to_load = "FarmScene"

func _on_body_entered(body):
	var path_to_scene = "res://Assets/Scenes/" + scene_to_load + ".tscn"
	if body.is_in_group("player"):
		get_tree().change_scene_to_file(path_to_scene)
