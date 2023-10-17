extends Area3D

@onready var Position = Vector3(-3.289, 1, -0.991)

var charpath = "res://Assets/Sprites/Characters/Player/SpriteMan_HoldingROD.png"
var sprite = null

@onready var player = get_tree().current_scene.get_node("Player")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	






func _on_area_entered(area):
	
	player.position.x = -3.289
	player.position.z = -0.991
	
	set_block_signals(true)
	
	
