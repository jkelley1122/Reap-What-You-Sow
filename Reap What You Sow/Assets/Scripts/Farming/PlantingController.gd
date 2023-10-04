extends Area3D # In Godot, to detect triggers, we'll use an Area node.

var crop = 0
@export var new_mat: Material # Equivalent to public Material in Unity
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
var plants = [corn,carrot]


# Start
func _ready():
	$Sprite3D.texture = plants[crop][0]
	#pass
	
# OnTriggerEnter
# Look into signals in Godot if you want to better understand how this works.
func _on_body_entered(body: PhysicsBody3D): 
	if plants[crop].find($Sprite3D.texture) != 4:
		$Sprite3D.texture = plants[crop][plants[crop].find($Sprite3D.texture) +1]

func _physics_process(delta):
	if Input.is_action_just_pressed("next_crop"):
		if crop == len(plants)-1:
			crop = 0
		else:
			crop += 1
