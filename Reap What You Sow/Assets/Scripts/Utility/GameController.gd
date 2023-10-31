extends Node3D

@onready var town_reputation = 100.0
@onready var player_health = 100.0
@onready var player_stamina = 100.0
@onready var player_sanity = 100.0
@onready var player_money = 0.0
@onready var player_crop = 'broccoli'
@onready var player_position = Vector3(0, 0.236, 0)
@onready var time = [55, 23, 29, 3, 0]
@onready var reputation = [100, 75, 50, 25]
	#0 - Rana
	#1 - Hampton
	#2 - Silas
	#3 - Guinness
@onready var spawn_point = null

# Timer
var timer = Timer.new()

const SECONDS_IN_MINUTE = 60
const MINUTES_IN_DAY = 24
const DAYS_IN_MONTH = 30
const MONTHS_IN_YEAR = 4

var current_scene = null
var player = null
var npcs = null
var hud = null

func _ready():
	self.add_child(timer)
	timer.set_wait_time(1)  # 1 second in real-time
	timer.timeout.connect(_on_timer_timeout)
	timer.start()
	
# Called when the node enters the scene tree for the first time.
func change_scene():
	current_scene = get_tree().current_scene
	player = current_scene.get_node("Player")
	npcs = current_scene.get_node("NPCs")
	hud = player.get_node("HUD")
	hud.update_display(time[0], time[1], time[2], time[3], time[4])
	
	if GameController.spawn_point:
		var spawn_position = current_scene.get_node("Spawns").get_node(GameController.spawn_point).global_position
		GameController.player_position = spawn_position
		GameController.spawn_point = null
	if player:
		set_player_values(player)
	
func set_player_values(player):
	player.health = GameController.player_health
	player.stamina = GameController.player_stamina
	player.sanity = GameController.player_sanity
	player.money = GameController.player_money
	player.position = GameController.player_position
	player.get_node("FarmPlot").croptype = player.get_node("FarmPlot").plants.find(GameController.player_crop)

func _on_timer_timeout():
	time[0] += 1
	if time[0] >= SECONDS_IN_MINUTE:
		time[0] = 0
		time[1] += 1
		if time[1] >= MINUTES_IN_DAY:
			time[1] = 0
			time[2] += 1
			if time[2] >= DAYS_IN_MONTH:
				time[2] = 0
				time[3] += 1
				if time[3] >= MONTHS_IN_YEAR:
					time[3] = 0
					time[4] += 1

	if hud:
		hud.update_display(time[0], time[1], time[2], time[3], time[4])
