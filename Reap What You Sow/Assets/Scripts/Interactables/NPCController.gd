extends CharacterBody3D

@export var npc_name = "Rana"
var reputation = 100

@onready var dialogue_menu = $DialogueMenu
@onready var animator: AnimationPlayer = $DialogueMenu/AnimationPlayer

var rana_sprite = load("res://Assets/Sprites/Characters/Rana/spr_Rana_front.png")
var hampton_sprite = load("res://Assets/Sprites/Characters/Hampton/spr_Hampton_front.png")
var silas_sprite = load("res://Assets/Sprites/Characters/Silas/spr_Silas_Front.png")
var guiness_sprite = load("res://Assets/Sprites/Characters/Guiness/spr_Guiness_front.png")

func _ready():
	match npc_name:
		"Rana":
			$Sprite3D.texture = rana_sprite
			reputation = GameController.reputation[0]
		"Hampton":
			$Sprite3D.texture = hampton_sprite
			reputation = GameController.reputation[1]
		"Silas":
			$Sprite3D.texture = silas_sprite
			reputation = GameController.reputation[2]
		"Guiness":
			$Sprite3D.texture = guiness_sprite
			reputation = GameController.reputation[3]

func talk():
	if (dialogue_menu.has_method("start_dialogue")):
		dialogue_menu.start_dialogue(npc_name, reputation)

