extends CanvasLayer

var dialogue_ui : Node
var npc_name : String = ""
var npc_reputation : float = 0
var dialogue_end : bool = false
var dialogue_sprite = null

const CHAR_READ_RATE = 0.05

enum State {
	READY,
	READING,
	FINISHED
}

var current_state = State.READY
var text_queue = []

@onready var player = get_tree().current_scene.get_node("Player")
@onready var HUD = player.get_node("HUD")

@onready var lbl_npc_name: Label = $MarginContainer/MarginContainer/VBoxContainer/CharacterName
@onready var lbl_dialogue: Label = $MarginContainer/MarginContainer/VBoxContainer/Dialogue
@onready var panel: Panel = $MarginContainer/Panel
@onready var img_dialogue_sprite: TextureRect = $DialogueSprite

var tween
func _ready():
	hide()
	
func _input(event):
	if event.is_action_pressed("ui_interact"):
		if current_state == State.READING:
			skip_reading()
		elif current_state == State.FINISHED && !text_queue.is_empty():
			display_text()
		elif current_state == State.FINISHED:
			end_dialogue()

# This function sets up and shows the dialogue UI
func start_dialogue(name: String, reputation: float, dialoguepath: String):
	HUD.hide()
	npc_name = name
	npc_reputation = reputation
	dialogue_sprite = load(dialoguepath + name + "DialogueSprite.png")
	var text_one = ""
	var text_two = ""
	match npc_name:
		"Rana":
			text_one = "Hi! Welcome to Edith's Market! Edith's out of town today so I'm covering for her."
			text_two = "If you want to sell some crops or fish then drop it off in the red box on the left. If you want to buy some seeds just select the green box on the right. It'll be $500 for a set of seeds!"
		"Hampton":
			text_one = "Howdy there farmer! Hope you're enjoying your day. If you're looking to make some money, sell any crops or fish you have in this store."
			text_two = "You can catch fish down by the river, and I'd hope someone of your profession knows where to get their crops, but I'd recommend you start at your farm down the path."
		"Iris":
			text_one = "Hey. If you're looking to do some fishing just walk up to the river and cast your rod, of course that means you should have your fishing rod in hand, not going to be catching much of anything without it."
			text_two = "Fishing's a game of luck around here so don't expect to get a fish every time. Though I hear there's a rare fish in that river."
		_:
			text_one = "Hello Farmer!"
			text_two = "Your reputation with me, " + npc_name + ", is " + str(npc_reputation)
	queue_text(text_one)
	queue_text(text_two)
	show()
	display_text()
	
func queue_text(next_text):
	text_queue.push_back(next_text)
	
# This function hides the dialogue UI
func end_dialogue():
	lbl_dialogue.visible_ratio = 0.0
	change_state(State.READY)
	player.current_state = player.State.Transition
	HUD.show()
	hide()

# Sets up the UI elements with provided values
func display_text():
	var next_text = text_queue.pop_front()
	lbl_npc_name.text = npc_name
	img_dialogue_sprite.texture = dialogue_sprite
	lbl_dialogue.text = next_text
	change_state(State.READING)
	lbl_dialogue.visible_ratio = 0.0
	
	tween = $MarginContainer.create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(lbl_dialogue, "visible_ratio", 1, len(next_text) * CHAR_READ_RATE)
	
	await tween.finished
	change_state(State.FINISHED)
	return

func skip_reading():
	lbl_dialogue.visible_ratio = 1.0
	tween.stop()
	current_state = State.FINISHED
	
func change_state(next_state):
	current_state = next_state

