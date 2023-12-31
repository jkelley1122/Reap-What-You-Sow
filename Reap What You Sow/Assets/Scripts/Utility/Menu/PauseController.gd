extends CanvasLayer

@onready var resume_button: Button = find_child("ResumeButton")
@onready var menu_button: Button = find_child("MenuButton")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if get_tree().paused:
			resume()
		else:
			pause()
	pass

func _ready() -> void:
	hide()
	resume_button.pressed.connect(resume)
	menu_button.pressed.connect(back_to_menu)

func resume():
	hide()
	get_tree().paused = false


func pause():
	show()
	get_tree().paused = true

	
func back_to_menu():
	resume()
	get_tree().change_scene_to_file("res://Assets/Scenes/TitleScene.tscn")
