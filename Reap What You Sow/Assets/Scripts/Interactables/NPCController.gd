extends CharacterBody3D

@export var npc_name = "Rana"
var reputation = 100

@onready var dialogue_menu = $DialogueMenu
@onready var animator: AnimationPlayer = $DialogueMenu/AnimationPlayer

var charpath = "res://Assets/Sprites/Characters/"
var dialoguepath = null
var sprite = null

func _ready():
	charpath += npc_name + "/"
	dialoguepath = charpath + "Dialogue/"
	
	match npc_name:
		"Rana":
			sprite = load(charpath + "spr_Rana_front.png")
			reputation = GameController.reputation[0]
		"Hampton":
			sprite = load(charpath + "spr_Hampton_front.png")
			reputation = GameController.reputation[1]
		"Silas":
			sprite = load(charpath + "spr_Silas_front.png")
			reputation = GameController.reputation[2]
		"Guinness":
			sprite = load(charpath + "spr_Guinness_front.png")
			reputation = GameController.reputation[3]

	$Sprite3D.texture = sprite
func talk():
	if (dialogue_menu.has_method("start_dialogue")):
		dialogue_menu.start_dialogue(npc_name, reputation, dialoguepath)

