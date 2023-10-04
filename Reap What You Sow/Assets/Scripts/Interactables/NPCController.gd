extends CharacterBody3D

@export var npc_name = "Rana"

@onready var dialogue_menu = $DialogueMenu
@onready var animator: AnimationPlayer = $DialogueMenu/AnimationPlayer

func _ready():
	match npc_name:
		"Rana":
func talk():
	if (dialogue_menu.has_method("start_dialogue")):
		dialogue_menu.start_dialogue(npc_name)

