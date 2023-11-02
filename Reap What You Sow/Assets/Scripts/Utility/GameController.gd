extends Node3D

@onready var town_reputation = 100.0
@onready var player_health = 100.0
@onready var player_stamina = 100.0
@onready var player_sanity = 100.0
@onready var player_money = 0.0
@onready var player_crop = 'broccoli'
@onready var player_position = Vector3(0, 0.236, 0)
@onready var player_item = "No Item"
@onready var time = [55, 23, 29, 3, 0]
	#0 - Seconds
	#1 - Minutes
	#2 - Days
	#3 - Months
	#4 - Years
@onready var reputation = [100, 75, 50, 25, 15, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
	#0 - Rana
	#1 - Hampton
	#2 - Silas
	#3 - Guinness
	#4 - Iris
	#5 - Sheriff
	#6 - Deputy
	#7 - Stakes
	#8 - Dog
	#9 - Blacksmith
	#10 - Sage
	#11 - Edith
	#12 - Carpenter
	#13 - Richard
	#14 - Dante
	#15 - Mary
	#16 - BSDaughter
	#17 - Tobias
	#18 - Reuben
	#19 - Cecilia
	#20 - Vivian
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

var game_start = false;

func _ready():
	self.add_child(timer)
	timer.set_wait_time(1)  # 1 second in real-time
	timer.timeout.connect(_on_timer_timeout)
	timer.start()
	
	
func _process(delta):
	if player:
		if GameController.game_start:
			change_scene()
			GameController.game_start = false
		if player.is_sleeping:
			time[0] = 0
			if time[1] < 6:
				time[2] = time[2]
			elif time[2] >= DAYS_IN_MONTH:
				time[2] = 0
				time[3] = time[3]+1
			else:
				time[2] = time[2] + 1
			time[1] = 6
			
			if time[3] >= MONTHS_IN_YEAR:
				time[3] = 0
				time[4] = time[4]+1
			else:
				time[3] = time[3]
				time[4] = time[4]

			player.is_sleeping = false
		
	if hud:
		hud.update_display(time[0], time[1], time[2], time[3], time[4])

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
	player.cur_item = GameController.player_item
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
