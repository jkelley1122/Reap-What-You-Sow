extends CharacterBody3D

@export var npc_name = "Rana"
@export var npc_reputation = 100

@onready var dialogue_menu = $DialogueMenu
@onready var animator: AnimationPlayer = $DialogueMenu/AnimationPlayer
	
func talk():
	if (dialogue_menu.has_method("start_dialogue")):
		dialogue_menu.start_dialogue("Rana", 95)

