extends ColorRect

const MONTH_NAMES = ["Spring", "Summer", "Autumn", "Winter"]
const START_YEAR = 1982
@onready var inventory_ui_container = $FarmUI/SeedsContainer
@onready var current_scene = get_tree().current_scene
@onready var player = get_tree().current_scene.get_node("Player")
@onready var inventory = player.get_node("Inventory")
@onready var seeds_pouch = player.get_node("SeedsPouch")

var hide_instructions = false

@onready var select = $Hotbar/Select
@onready var slot_one = $Hotbar/Slot1
@onready var slot_two = $Hotbar/Slot2
@onready var slot_three = $Hotbar/Slot3
@onready var slot_four = $Hotbar/Slot4
@onready var slot_five = $Hotbar/Slot5
@onready var slot_six = $Hotbar/Slot6
@onready var slot_seven = $Hotbar/Slot7
@onready var slot_eight = $Hotbar/Slot8
@onready var slot_nine = $Hotbar/Slot9
@onready var slot_ten = $Hotbar/Slot10

@onready var slot_lbl_one = $Hotbar/Slot1Label
@onready var slot_lbl_two = $Hotbar/Slot2Label
@onready var slot_lbl_three = $Hotbar/Slot3Label
@onready var slot_lbl_four = $Hotbar/Slot4Label
@onready var slot_lbl_five = $Hotbar/Slot5Label
@onready var slot_lbl_six = $Hotbar/Slot6Label
@onready var slot_lbl_seven = $Hotbar/Slot7Label
@onready var slot_lbl_eight = $Hotbar/Slot8Label
@onready var slot_lbl_nine = $Hotbar/Slot9Label
@onready var slot_lbl_ten = $Hotbar/Slot10Label

var sel_distance = 32
var sel_y_coord = 0
var sel_x_start = -143
var cur_slot = GameController.hud_cur_slot

@onready var item_sprites = [
	load("res://Assets/Sprites/Items/spr_hoe.png"), #Hoe
	load("res://Assets/Sprites/Items/spr_fishing_rod.png"), #Fishing pole
	load("res://Assets/Sprites/Crops/Blackberry/PlantBlackberry[PICKED].png"), #Blackberry
	load("res://Assets/Sprites/Crops/Broccoli/PlantBroccoli[PICKED].png"), #Broccoli
	load("res://Assets/Sprites/Crops/Carrot/PlantCarrot[PICKED]_Sprite.png"), #Carrot
	load("res://Assets/Sprites/Crops/Cauliflower/PlantCauliflower[PICKED].png"), #Cauliflower
	load("res://Assets/Sprites/Crops/Corn/PlantCorn[PICKED].png"), #Corn
	load("res://Assets/Sprites/Crops/Raspberry/PlantRaspberry[PICKED].png"), #Raspberry
	load("res://Assets/Sprites/Crops/Tobacco/PlantTobacco[PICKED].png"), #Tobacco
	load("res://Assets/Sprites/Crops/Tomato/PlantTomato[PICKED].png"), #Tomato
	load("res://Assets/Sprites/Crops/Wheat/PlantWheat[PICKED].png"), #Wheat
	load("res://Assets/Sprites/Fish/SalmonFish_Sprite.png"), #Salmon
	load("res://Assets/Sprites/Fish/BassFish_Sprite.png"), #Bass
	load("res://Assets/Sprites/Fish/CarpFish_Sprite.png"), #Carp
	load("res://Assets/Sprites/Fish/GoldenFish_Sprite.png"), #Golden
	load("res://Assets/Sprites/Fish/DemonFish_Sprite.png"), #Demon
	]

func _ready():
	select.position = Vector2(sel_x_start+(sel_distance*(cur_slot)), sel_y_coord)

func _process(delta):
	if current_scene.name == "FarmScene":
		$FarmUI.show()
		if hide_instructions:
			$FarmUI/FarmInstructions.hide()
		else:
			$FarmUI/FarmInstructions.show()
	elif current_scene.name == "MarketScene":
		$FarmUI.show()
		$FarmUI/FarmInstructions.hide()
		$FarmUI/Cur_Crop.hide()
		$FarmUI/SeedsContainer.show()
	else:
		$FarmUI.hide()
		

		
func _input(event):
	if event.is_action_pressed("debug_menu"):
		hide_instructions = not hide_instructions

	if event.is_action_pressed("ui_one"):
		cur_slot = 0
	if event.is_action_pressed("ui_two"):
		cur_slot = 1
	if event.is_action_pressed("ui_three"):
		cur_slot = 2
	if event.is_action_pressed("ui_four"):
		cur_slot = 3
	if event.is_action_pressed("ui_five"):
		cur_slot = 4
	if event.is_action_pressed("ui_six"):
		cur_slot = 5
	if event.is_action_pressed("ui_seven"):
		cur_slot = 6
	if event.is_action_pressed("ui_eight"):
		cur_slot = 7
	if event.is_action_pressed("ui_nine"):
		cur_slot = 8
	if event.is_action_pressed("ui_zero"):
		cur_slot = 9
		
	var keys_array = GameController.player_inventory.keys()
	if cur_slot < keys_array.size():
		player.cur_item = keys_array[cur_slot]
	else:
		player.cur_item = "No Item"
	GameController.hud_cur_slot = cur_slot
	GameController.player_item = player.cur_item
	
	select.position = Vector2(sel_x_start+(sel_distance*(cur_slot)), sel_y_coord)
		
		
func update_display(seconds, minutes, days, months, years):
	$Time.text = "%s:%s, Day %s of %s %s" % [str(minutes).lpad(2, '0'), str(seconds).lpad(2, '0'), str(days + 1), MONTH_NAMES[months], str(START_YEAR + years)]
	$Health.text = "Health: " + str(GameController.player_health)
	$Stamina.text = "Stamina: " + str(GameController.player_stamina)
	$Sanity.text = "Sanity: " + str(GameController.player_sanity)
	$Money.text = "Money: " + str(GameController.player_money)
	$DEBUG_FPS.text = "[DEBUG] FPS: " + str(Engine.get_frames_per_second())
	$Cur_Item.text = GameController.player_item
	$FarmUI/Cur_Crop.text = str(GameController.player_crop)
	

func update_seeds_display():
	var seeds = seeds_pouch.get_all_items() #gets all current items in inventory
	
	for child in inventory_ui_container.get_children(): #prevents the inventory from duping itself on an outside -
		child.queue_free()                              #inventory call

	for seed_name in seeds.keys():
		var seed_button = Button.new()
		seed_button.focus_mode = Control.FOCUS_NONE
		seed_button.text = seed_name + ": " + str(seeds[seed_name])
		
		# Connect the button press to a method with the item_name as an argument
		seed_button.connect("pressed", _on_seed_button_pressed.bind(seed_name))
		
		inventory_ui_container.add_child(seed_button)

func update_hotbar():
	var keys_array = GameController.player_inventory.keys()
	var num_items_to_cycle = min(keys_array.size(), 10)
	var slot_to_update = slot_one
	var label_to_update = slot_lbl_one
	
	for i in range(10):
		var item_key = null
		var item_value = 0
		var item_amount = 0
		if i < num_items_to_cycle:
			item_key = keys_array[i]
			item_value = GameController.player_inventory[item_key]
		match(i):
			0:
				slot_to_update = slot_one
				label_to_update = slot_lbl_one
			1:
				slot_to_update = slot_two
				label_to_update = slot_lbl_two
			2:
				slot_to_update = slot_three
				label_to_update = slot_lbl_three
			3:
				slot_to_update = slot_four
				label_to_update = slot_lbl_four
			4:
				slot_to_update = slot_five
				label_to_update = slot_lbl_five
			5:
				slot_to_update = slot_six
				label_to_update = slot_lbl_six
			6:
				slot_to_update = slot_seven
				label_to_update = slot_lbl_seven
			7:
				slot_to_update = slot_eight
				label_to_update = slot_lbl_eight
			8:
				slot_to_update = slot_nine
				label_to_update = slot_lbl_nine
			9:
				slot_to_update = slot_ten
				label_to_update = slot_lbl_ten
		label_to_update.text = str(item_value)
		match(item_key):
			"Hoe":
				slot_to_update.texture = item_sprites[0]
			"Fishing Pole":
				slot_to_update.texture = item_sprites[1]
			"Blackberry":
				slot_to_update.texture = item_sprites[2]
			"Broccoli":
				slot_to_update.texture = item_sprites[3]
			"Carrot":
				slot_to_update.texture = item_sprites[4]
			"Cauliflower":
				slot_to_update.texture = item_sprites[5]
			"Corn":
				slot_to_update.texture = item_sprites[6]
			"Raspberry":
				slot_to_update.texture = item_sprites[7]
			"Tobacco":
				slot_to_update.texture = item_sprites[8]
			"Tomato":
				slot_to_update.texture = item_sprites[9]
			"Wheat":
				slot_to_update.texture = item_sprites[10]
			"Bass":
				slot_to_update.texture = item_sprites[12]
			"Carp":
				slot_to_update.texture = item_sprites[13]
			"Salmon":
				slot_to_update.texture = item_sprites[11]
			"Golden Fish":
				slot_to_update.texture = item_sprites[14]
			"Demon Fish":
				slot_to_update.texture = item_sprites[15]
			_:
				slot_to_update.texture = null
			
func _on_seed_button_pressed(seed_name):
	# Set the active item in the player script or another appropriate place
	player.set_cur_seed(seed_name)
