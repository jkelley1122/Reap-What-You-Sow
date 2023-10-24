extends Sprite3D
var time_start = 0 # elapsed time of the whole project, at the creation of the node instance attached to this script
var time_now = 0 # running time check for the elapsed time of whole project, updated each frame
var crop
var stage
var corn = [#corn
	load("res://Assets/Sprites/Crops/Corn/PlantCorn[STAGE1].png"),
	load("res://Assets/Sprites/Crops/Corn/PlantCorn[STAGE2].png"),
	load("res://Assets/Sprites/Crops/Corn/PlantCorn[STAGE3].png"),
	load("res://Assets/Sprites/Crops/Corn/PlantCorn[STAGE4].png"),
	load("res://Assets/Sprites/Crops/Corn/PlantCorn[STAGE5].png"),
	load("res://Assets/Sprites/Crops/Corn/PlantCorn[PICKED].png")
	]
var carrot = [#carrots
	load("res://Assets/Sprites/Crops/Carrot/PlantCarrot[STAGE1]_Sprite.png"),
	load("res://Assets/Sprites/Crops/Carrot/PlantCarrot[STAGE2]_Sprite.png"),
	load("res://Assets/Sprites/Crops/Carrot/PlantCarrot[STAGE3]_Sprite.png"),
	load("res://Assets/Sprites/Crops/Carrot/PlantCarrot[STAGE4]_Sprite.png"),
	load("res://Assets/Sprites/Crops/Carrot/PlantCarrot[STAGE5]_Sprite.png"),
	load("res://Assets/Sprites/Crops/Carrot/PlantCarrot[PICKED]_Sprite.png")
]
var blackberry = [#blackberries
	load("res://Assets/Sprites/Crops/Blackberry/PlantBlackberry[STAGE1].png"),
	load("res://Assets/Sprites/Crops/Blackberry/PlantBlackberry[STAGE2].png"),
	load("res://Assets/Sprites/Crops/Blackberry/PlantBlackberry[STAGE3].png"),
	load("res://Assets/Sprites/Crops/Blackberry/PlantBlackberry[STAGE4].png"),
	load("res://Assets/Sprites/Crops/Blackberry/PlantBlackberry[STAGE5].png"),
	load("res://Assets/Sprites/Crops/Blackberry/PlantBlackberry[PICKED].png"),
]
var raspberry = [#Raspberries
	load("res://Assets/Sprites/Crops/Raspberry/PlantRaspberry[STAGE1].png"),
	load("res://Assets/Sprites/Crops/Raspberry/PlantRaspberry[STAGE2].png"),
	load("res://Assets/Sprites/Crops/Raspberry/PlantRaspberry[STAGE3].png"),
	load("res://Assets/Sprites/Crops/Raspberry/PlantRaspberry[STAGE4].png"),
	load("res://Assets/Sprites/Crops/Raspberry/PlantRaspberry[STAGE5].png"),
	load("res://Assets/Sprites/Crops/Raspberry/PlantRaspberry[PICKED].png"),
	]
	
var tobacco = [#tobacco
	load("res://Assets/Sprites/Crops/Tobacco/PlantTobacco[STAGE1].png"),
	load("res://Assets/Sprites/Crops/Tobacco/PlantTobacco[STAGE2].png"),
	load("res://Assets/Sprites/Crops/Tobacco/PlantTobacco[STAGE3].png"),
	load("res://Assets/Sprites/Crops/Tobacco/PlantTobacco[STAGE4].png"),
	load("res://Assets/Sprites/Crops/Tobacco/PlantTobacco[STAGE5].png"),
	load("res://Assets/Sprites/Crops/Tobacco/PlantTobacco[PICKED].png"),
]
var broccoli = [#broccoli
	load("res://Assets/Sprites/Crops/Broccoli/PlantBroccoli[STAGE1].png"),
	load("res://Assets/Sprites/Crops/Broccoli/PlantBroccoli[STAGE2].png"),
	load("res://Assets/Sprites/Crops/Broccoli/PlantBroccoli[STAGE3].png"),
	load("res://Assets/Sprites/Crops/Broccoli/PlantBroccoli[STAGE4].png"),
	load("res://Assets/Sprites/Crops/Broccoli/PlantBroccoli[STAGE5].png"),
	load("res://Assets/Sprites/Crops/Broccoli/PlantBroccoli[PICKED].png"),
]
var plants = [corn,carrot, blackberry, raspberry, tobacco, broccoli]

# Called when the node enters the scene tree for the first time.
func _ready():
	stage = 0
	crop = 0
	time_start = Time.get_ticks_msec()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#pass
	texture = plants[crop][stage]
	time_now = Time.get_ticks_msec()
	if (time_now - time_start)%1000 == 0 && stage != 4:
		age_up()

func age_up():
	stage += 1
