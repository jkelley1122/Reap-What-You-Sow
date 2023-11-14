extends StaticBody3D


var sellable_items = {
	'Corn': 100, 
	'Carrot': 200, 
	'Blackberry': 300, 
	'Raspberry': 200, 
	'Tobacco': 300, 
	'Broccoli': 100, 
	'Wheat': 200, 
	'Tomato': 300,
	'Cauliflower': 100,
	'Bass': 5, 
	'Carp': 10, 
	'Salmon': 15, 
	'Golden Fish': 1000, 
	'Demon Fish': 50,
}

@onready var current_scene = get_tree().current_scene
@onready var player = get_tree().current_scene.get_node("Player")
@onready var HUD = get_tree().current_scene.get_node("Player").get_node("HUD")
var seed_list = {
	"Corn Seeds": 3,
	"Carrot Seeds": 3,
	"Blackberry Seeds": 3,
	"Raspberry Seeds": 3,
	"Tobacco Seeds": 3,
	"Broccoli Seeds": 3,
	"Wheat Seeds": 3,
	"Tomato Seeds": 3,
	"Cauliflower Seeds": 3,
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func buy():
	if player.money >= 500:
		for seed in seed_list.keys():
			player.seeds_pouch.add_seed(seed, 3)
		
		player.money -= 500
		GameController.player_money = player.money
	
func sell():
	var i = 0
	for item in sellable_items:
		if player.cur_item == item:
			player.inventory.remove_item(player.cur_item, 1)
			player.money += sellable_items[item]
			GameController.player_money = player.money

