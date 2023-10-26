extends ColorRect

const MONTH_NAMES = ["Spring", "Summer", "Autumn", "Winter"]
const START_YEAR = 1982
@onready var inventory_ui_container = $InventoryContainer
@onready var player = get_tree().current_scene.get_node("Player")
@onready var inventory = player.get_node("Inventory")

func _input(event):
	if event.is_action_pressed("debug_menu"):
		if visible:
			hide()
		else:
			show()
		
func update_display(seconds, minutes, days, months, years):
	$Time.text = "%s:%s, Day %s of %s %s" % [str(minutes).lpad(2, '0'), str(seconds).lpad(2, '0'), str(days + 1), MONTH_NAMES[months], str(START_YEAR + years)]
	$Health.text = "Health: " + str(GameController.player_health)
	$Stamina.text = "Stamina: " + str(GameController.player_stamina)
	$Sanity.text = "Sanity: " + str(GameController.player_sanity)
	$Money.text = "Money: " + str(GameController.player_money)
	$DEBUG_FPS.text = "[DEBUG] FPS: " + str(Engine.get_frames_per_second())
	$Cur_Item.text = 'Item: ' + GameController.player_item
	$Cur_Crop.text = 'Crop: ' + str(GameController.player_crop)
	

func update_inventory_ui():
	var items = inventory.get_all_items()
	for item_name in items.keys():
		var item_button = Button.new()
		item_button.focus_mode = Control.FOCUS_NONE
		item_button.text = item_name + ": " + str(items[item_name])
		
		# Connect the button press to a method with the item_name as an argument
		item_button.connect("pressed", _on_item_button_pressed.bind(item_name))
		
		inventory_ui_container.add_child(item_button)

func _on_item_button_pressed(item_name):
	# Set the active item in the player script or another appropriate place
	player.set_cur_item(item_name)
