extends Area3D


var charpath = "res://Assets/Sprites/Characters/Player/SpriteMan_HoldingROD.png"
var sprite = load(charpath)

@onready var player = get_tree().current_scene.get_node("Player")
var stop_movement = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	






func _on_area_entered(area):
	
	if player.is_in_group("player"):
		player.position.x = -3.289
		player.position.z = -0.991
		stop_movement = true
		set_process_input(false)
		#player.texture = sprite
	
	
		
	
