extends ColorRect

var dialogue_ui : Node
var npc_name : String = ""
var npc_reputation : float = 0
var dialogue_end : bool = false
var dialogue_sprite = null

@onready var animator: AnimationPlayer = $AnimationPlayer
@onready var lbl_npc_name: Label = $PanelContainer/MarginContainer/VBoxContainer/CharacterName
@onready var lbl_dialogue: Label = $PanelContainer/MarginContainer/VBoxContainer/Dialogue
@onready var img_dialogue_sprite: TextureRect = $DialogueSprite
func _input(event):
	if not dialogue_end:
		if event.is_action_released("ui_interact"):
			dialogue_end = true
	else:
		if event.is_action_released("ui_interact"):
			dialogue_end = false
			end_dialogue()

# This function sets up and shows the dialogue UI
func start_dialogue(name: String, reputation: float, dialoguepath: String):
	npc_name = name
	npc_reputation = reputation
	dialogue_sprite = load(dialoguepath + name + "DialogueSprite.png")
	setup_ui()
	
	animator.play("StartTalking")
	get_tree().paused = true

# This function hides the dialogue UI
func end_dialogue():
	animator.play("StopTalking")
	get_tree().paused = false

# Sets up the UI elements with provided values
func setup_ui():
	lbl_npc_name.text = npc_name
	img_dialogue_sprite.texture = dialogue_sprite
	lbl_dialogue.text = "Your reputation with me, " + npc_name + ", is " + str(npc_reputation)
	# This is where I'll set labels, opinions, etc. to the UI
	# Example:
	# dialogue_ui.get_node("NameLabel").text = npc_name
	return
