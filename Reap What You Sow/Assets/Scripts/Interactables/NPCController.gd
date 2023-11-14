extends CharacterBody3D

@export var npc_name = "Rana"
var reputation = 100

@onready var dialogue_menu = $DialogueMenu

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
		"Iris":
			sprite = load(charpath + "spr_Iris_front.png")
			reputation = GameController.reputation[4]
		"Sheriff":
			sprite = load(charpath + "spr_Sheriff_front.png")
			reputation = GameController.reputation[5]
		"Deputy":
			sprite = load(charpath + "spr_Deputy_front.png")
			reputation = GameController.reputation[6]
		"Stakes":
			sprite = load(charpath + "spr_Stakes_front.png")
			reputation = GameController.reputation[7]
		"Dog":
			sprite = load(charpath + "spr_Dog_front.png")
			reputation = GameController.reputation[8]
		"Blacksmith":
			sprite = load(charpath + "spr_Blacksmith_front.png")
			reputation = GameController.reputation[9]
		"Sage":
			sprite = load(charpath + "spr_Sage_front.png")
			reputation = GameController.reputation[10]
		"Edith":
			sprite = load(charpath + "spr_Edith_front.png")
			reputation = GameController.reputation[11]
		"Carpenter":
			sprite = load(charpath + "spr_Carpenter_front.png")
			reputation = GameController.reputation[12]
		"Richard":
			sprite = load(charpath + "spr_Richard_front.png")
			reputation = GameController.reputation[13]
		"Dante":
			sprite = load(charpath + "spr_Dante_front.png")
			reputation = GameController.reputation[14]
		"Mary":
			sprite = load(charpath + "spr_Mary_front.png")
			reputation = GameController.reputation[15]
		"BSDaughter":
			sprite = load(charpath + "spr_BSDaughter_front.png")
			reputation = GameController.reputation[16]
		"Tobias":
			sprite = load(charpath + "spr_Tobias_front.png")
			reputation = GameController.reputation[17]
		"Reuben":
			sprite = load(charpath + "spr_Reuben_front.png")
			reputation = GameController.reputation[18]
		"Cecilia":
			sprite = load(charpath + "spr_Cecilia_front.png")
			reputation = GameController.reputation[19]
		"Vivian":
			sprite = load(charpath + "spr_Vivian_front.png")
			reputation = GameController.reputation[20]
			
	$Sprite3D.texture = sprite
	
func talk():
	if (dialogue_menu.has_method("start_dialogue")):
		dialogue_menu.start_dialogue(npc_name, reputation, dialoguepath)

