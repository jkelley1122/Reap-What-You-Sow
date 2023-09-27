extends Node3D

@onready var town_reputation = 100.0
@onready var player_health = 100.0
@onready var player_stamina = 100.0
@onready var player_sanity = 100.0
@onready var player_money = 0.0
@onready var player_position = Vector3(0, 0.236, 0)
@onready var time = [0, 0, 0, 0, 0]
@onready var reputation = {}
@onready var spawn_point = null

# Called when the node enters the scene tree for the first time.
func change_scene():
	var current_scene = get_tree().current_scene
	var player = current_scene.get_node("Player")
	var timer = current_scene.get_node("Utility").get_node("Timer")
	if GameController.spawn_point:
		var spawn_position = current_scene.get_node("Spawns").get_node(GameController.spawn_point).global_position
		GameController.player_position = spawn_position
		GameController.spawn_point = null
	if player:
		set_player_values(player)
	if timer:
		set_time(timer)
	
func set_player_values(player):
	player.health = GameController.player_health
	player.stamina = GameController.player_stamina
	player.sanity = GameController.player_sanity
	player.money = GameController.player_money
	player.position = GameController.player_position

func set_time(timer):
	timer.seconds = time[0]
	timer.minutes = time[1]
	timer.days = time[2]
	timer.months = time[3]
	timer.years = time[4]
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
