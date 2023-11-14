extends CharacterBody3D

var time_start = 0 # elapsed time of the whole project, at the creation of the node instance attached to this script
var time_now = 0 # running time check for the elapsed time of whole project, updated each frame
var time_planted
var crop
var stage

var inventory

@onready var current_scene = get_tree().current_scene
@onready var player = get_tree().current_scene.get_node("Player")
@onready var farm_plot = get_tree().current_scene.get_node("Player").get_node("FarmPlot")
@onready var HUD = get_tree().current_scene.get_node("Player").get_node("HUD")
@onready var sprite = $Sprite3D

var corn = [#corn
	load("res://Assets/Sprites/Crops/Corn/PlantCorn[STAGE1].png"),
	load("res://Assets/Sprites/Crops/Corn/PlantCorn[STAGE2].png"),
	load("res://Assets/Sprites/Crops/Corn/PlantCorn[STAGE3].png"),
	load("res://Assets/Sprites/Crops/Corn/PlantCorn[STAGE4].png"),
	load("res://Assets/Sprites/Crops/Corn/PlantCorn[STAGE5].png"),
	load("res://Assets/Sprites/Crops/Corn/PlantCorn[DEAD].png")
	]
var carrot = [#carrots
	load("res://Assets/Sprites/Crops/Carrot/PlantCarrot[STAGE1]_Sprite.png"),
	load("res://Assets/Sprites/Crops/Carrot/PlantCarrot[STAGE2]_Sprite.png"),
	load("res://Assets/Sprites/Crops/Carrot/PlantCarrot[STAGE3]_Sprite.png"),
	load("res://Assets/Sprites/Crops/Carrot/PlantCarrot[STAGE4]_Sprite.png"),
	load("res://Assets/Sprites/Crops/Carrot/PlantCarrot[STAGE5]_Sprite.png"),
	load("res://Assets/Sprites/Crops/Carrot/PlantCarrot[DEAD]_Sprite.png")
]
var blackberry = [#blackberries
	load("res://Assets/Sprites/Crops/Blackberry/PlantBlackberry[STAGE1].png"),
	load("res://Assets/Sprites/Crops/Blackberry/PlantBlackberry[STAGE2].png"),
	load("res://Assets/Sprites/Crops/Blackberry/PlantBlackberry[STAGE3].png"),
	load("res://Assets/Sprites/Crops/Blackberry/PlantBlackberry[STAGE4].png"),
	load("res://Assets/Sprites/Crops/Blackberry/PlantBlackberry[STAGE5].png"),
	load("res://Assets/Sprites/Crops/Blackberry/PlantBlackberry[DEAD].png"),
]
var raspberry = [#Raspberries
	load("res://Assets/Sprites/Crops/Raspberry/PlantRaspberry[STAGE1].png"),
	load("res://Assets/Sprites/Crops/Raspberry/PlantRaspberry[STAGE2].png"),
	load("res://Assets/Sprites/Crops/Raspberry/PlantRaspberry[STAGE3].png"),
	load("res://Assets/Sprites/Crops/Raspberry/PlantRaspberry[STAGE4].png"),
	load("res://Assets/Sprites/Crops/Raspberry/PlantRaspberry[STAGE5].png"),
	load("res://Assets/Sprites/Crops/Raspberry/PlantRaspberry[DEAD].png"),
	]
	
var tobacco = [#tobacco
	load("res://Assets/Sprites/Crops/Tobacco/PlantTobacco[STAGE1].png"),
	load("res://Assets/Sprites/Crops/Tobacco/PlantTobacco[STAGE2].png"),
	load("res://Assets/Sprites/Crops/Tobacco/PlantTobacco[STAGE3].png"),
	load("res://Assets/Sprites/Crops/Tobacco/PlantTobacco[STAGE4].png"),
	load("res://Assets/Sprites/Crops/Tobacco/PlantTobacco[STAGE5].png"),
	load("res://Assets/Sprites/Crops/Tobacco/PlantTobacco[DEAD].png"),
]
var broccoli = [#broccoli
	load("res://Assets/Sprites/Crops/Broccoli/PlantBroccoli[STAGE1].png"),
	load("res://Assets/Sprites/Crops/Broccoli/PlantBroccoli[STAGE2].png"),
	load("res://Assets/Sprites/Crops/Broccoli/PlantBroccoli[STAGE3].png"),
	load("res://Assets/Sprites/Crops/Broccoli/PlantBroccoli[STAGE4].png"),
	load("res://Assets/Sprites/Crops/Broccoli/PlantBroccoli[STAGE5].png"),
	load("res://Assets/Sprites/Crops/Broccoli/PlantBroccoli[DEAD].png"),
]
var wheat = [#wheat
	load("res://Assets/Sprites/Crops/Wheat/PlantWheat[STAGE1].png"),
	load("res://Assets/Sprites/Crops/Wheat/PlantWheat[STAGE2].png"),
	load("res://Assets/Sprites/Crops/Wheat/PlantWheat[STAGE3].png"),
	load("res://Assets/Sprites/Crops/Wheat/PlantWheat[STAGE4].png"),
	load("res://Assets/Sprites/Crops/Wheat/PlantWheat[STAGE5].png"),
	load("res://Assets/Sprites/Crops/Wheat/PlantWheat[DEAD].png")
]
var tomato = [#tomatoes
	load("res://Assets/Sprites/Crops/Tomato/PlantTomato[STAGE1].png"),
	load("res://Assets/Sprites/Crops/Tomato/PlantTomato[STAGE2].png"),
	load("res://Assets/Sprites/Crops/Tomato/PlantTomato[STAGE3].png"),
	load("res://Assets/Sprites/Crops/Tomato/PlantTomato[STAGE4].png"),
	load("res://Assets/Sprites/Crops/Tomato/PlantTomato[STAGE5].png"),
	load("res://Assets/Sprites/Crops/Tomato/PlantTomato[DEAD].png")
]
var cauliflower = [#cauliflower
	load("res://Assets/Sprites/Crops/Cauliflower/PlantCauliflower[STAGE1].png"),
	load("res://Assets/Sprites/Crops/Cauliflower/PlantCauliflower[STAGE2].png"),
	load("res://Assets/Sprites/Crops/Cauliflower/PlantCauliflower[STAGE3].png"),
	load("res://Assets/Sprites/Crops/Cauliflower/PlantCauliflower[STAGE4].png"),
	load("res://Assets/Sprites/Crops/Cauliflower/PlantCauliflower[STAGE5].png"),
	load("res://Assets/Sprites/Crops/Cauliflower/PlantCauliflower[DEAD].png"),
]
var plants = [corn,carrot, blackberry, raspberry, tobacco, broccoli, wheat, tomato, cauliflower]
var plant_names = ['Corn', 'Carrot', 'Blackberry', 'Raspberry', 'Tobacco', 'Broccoli', 'Wheat', 'Tomato', 'Cauliflower']

# Called when the node enters the scene tree for the first time.
func _ready():
	stage = 0
	crop = 0
	time_start = Time.get_ticks_msec()
	
	inventory = current_scene.get_node("Player").get_node("Inventory")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#pass
	sprite.texture = plants[crop][stage]
	time_now = Time.get_ticks_msec()
	
	
	#if (time_now - time_start)%1000 == 0 && stage != 4:
	#	age_up()
	
	stage = calculate_growth_stage()

func age_up():
	stage += 1
	
func harvest():
	if stage == 4:
		inventory.add_item(plant_names[crop], 1)
		GameController.remove_crop(self.global_transform.origin)
		self.queue_free()
	else:
		print("This crop is not ready to harvest!")

# Calculates the growth stage based off when the crop was planted
func calculate_growth_stage():
	var time_passed_seconds = (GameController.time[4] - time_planted[4])*GameController.MONTHS_IN_YEAR*GameController.DAYS_IN_MONTH*GameController.MINUTES_IN_DAY*GameController.SECONDS_IN_MINUTE+(GameController.time[3] - time_planted[3])*GameController.DAYS_IN_MONTH*GameController.MINUTES_IN_DAY*GameController.SECONDS_IN_MINUTE+(GameController.time[2] - time_planted[2])*GameController.MINUTES_IN_DAY*GameController.SECONDS_IN_MINUTE+(GameController.time[1] - time_planted[1])*GameController.SECONDS_IN_MINUTE+(GameController.time[0] - time_planted[0])
	var time_passed_days = floor(time_passed_seconds/GameController.SECONDS_IN_MINUTE/GameController.MINUTES_IN_DAY)
	
	# Uncomment these to see the calculations at work, 
	# the calculations are shown when you enter a scene with plants
	#print("Time Planted: " + str(time_planted))
	#print("Time Now: " + str(GameController.time))
	#print("Time Passed Seconds: " + str(time_passed_seconds))
	#print("Time Passed Days: " + str(time_passed_days))
	
	var growth_stage = min(time_passed_days, 4)
	return growth_stage

