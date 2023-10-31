extends Node

var game_data = {}
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
	




func _on_keybind_button_pressed():
	$Keybind_Popup.visible = true
func _on_audio_button_pressed():
	$Audio_Popup.visible = true
func _on_video_button_pressed():
	$Video_Popup.visible = true
func _on_display_button_pressed():
	$Display_Popup.visible = true
	




func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Assets/Scenes/TitleScene.tscn")
