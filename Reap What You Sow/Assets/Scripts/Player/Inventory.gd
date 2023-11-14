extends Node3D

# The inventory is a dictionary with item names as keys and quantities as values.
var inventory = {}
@onready var HUD = get_tree().current_scene.get_node("Player").get_node("HUD")

func add_seed(item_name: String, quantity: int):
	add_object(item_name, quantity)
	GameController.player_seeds = inventory
	HUD.update_seeds_display()
	
func add_item(item_name: String, quantity: int):
	add_object(item_name, quantity)
	GameController.player_inventory = inventory
	HUD.update_hotbar()

# Function to add an item to the inventory.
func add_object(item_name: String, quantity: int):
	if inventory.has(item_name):
		inventory[item_name] += quantity
	else:
		inventory[item_name] = quantity

func remove_seed(item_name: String, quantity: int):
	remove_object(item_name, quantity)
	GameController.player_seeds = inventory
	HUD.update_seeds_display()
	
func remove_item(item_name: String, quantity: int):
	remove_object(item_name, quantity)
	GameController.player_inventory = inventory
	HUD.update_hotbar()
	
# Function to remove an item from the inventory.
func remove_object(item_name: String, quantity: int):
	if inventory.has(item_name):
		inventory[item_name] -= quantity
		if inventory[item_name] <= 0:
			inventory.erase(item_name)

# Function to check if an item is in the inventory.
func has_item(item_name: String, quantity: int) -> bool:
	return inventory.has(item_name) and inventory[item_name] >= quantity

# Function to check if an item is in the inventory.
func has_seed(item_name: String, quantity: int) -> bool:
	return inventory.has(item_name) and inventory[item_name] >= quantity
	
# Function to get all items in the inventory.
func get_all_items() -> Dictionary:
	return inventory
	
func get_all_seeds() -> Dictionary:
	return inventory
