extends Node3D

var town_reputation = 100.0
var player_health = 100.0
var player_stamina = 100.0
var player_sanity = 100.0
var player_money = 0.0
var player_crop = 'broccoli'
var player_position = Vector3(0, 0.236, 0)
var player_item = "No Item"
var time = [55, 23, 29, 3, 0]
	#0 - Seconds
	#1 - Minutes
	#2 - Days
	#3 - Months
	#4 - Years
var reputation = [100, 75, 50, 25, 15, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
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
	#21 - Lawrence
var spawn_point = null

# Timer
var timer = Timer.new()

const SECONDS_IN_MINUTE = 60
const MINUTES_IN_DAY = 24
const DAYS_IN_MONTH = 30
const MONTHS_IN_YEAR = 4

const DAWN_START = 360.0
const DAY_START = 430.0
const DUSK_START = 1080.0
const NIGHT_START = 1050.0
const FULL_DAY = 1440.0

const DAY_COLOR = Color(1, 0.9, 0.8)
const NIGHT_COLOR = Color(0.5, 0.5, 1.0)

var current_scene = null
var player = null
var npcs = null
var hud = null
var directional_light = null


func _ready():
	self.add_child(timer)
	timer.set_wait_time(1)  # 1 second in real-time
	timer.timeout.connect(_on_timer_timeout)
	timer.start()
	change_scene()
	
func _process(delta):
	if player:
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
		
	if directional_light:
		update_lighting()
# Called when the node enters the scene tree for the first time.
func change_scene():
	current_scene = get_tree().current_scene
	player = current_scene.get_node("Player")
	print(current_scene)
	if player:
		print("This scene has a player")
		npcs = current_scene.get_node("NPCs")
		hud = player.get_node("HUD")
		directional_light = current_scene.get_node("Utility").get_node("DirectionalLight3D")
		hud.update_display(time[0], time[1], time[2], time[3], time[4])
		
		if GameController.spawn_point:
			var spawn_position = current_scene.get_node("Spawns").get_node(GameController.spawn_point).global_position
			GameController.player_position = spawn_position
			GameController.spawn_point = null
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

func update_lighting():
	# Example: game_time is in minutes, 0 = midnight, 720 = noon
	var game_time = (time[1] * 60 + time[0])
	var time_ratio = game_time / 1440.0  # Normalize time to a 0-1 range
	# Adjust the light angle for a simple day/night cycle
	var light_angle = Vector3(-30, 360 * time_ratio, 0)
	directional_light.rotation_degrees = light_angle

	# Adjust light color/intensity
	if game_time >= DAY_START and game_time < DUSK_START:  # Daytime
		directional_light.light_color = Color(1, 0.9, 0.8)
		directional_light.light_energy = 1.0
	elif game_time >= DAWN_START and game_time < DAY_START: # Dawn
		var phase_progress = (game_time - DAWN_START) / (DAY_START - DAWN_START)
		directional_light.light_color = Color(NIGHT_COLOR.lerp(DAY_COLOR, phase_progress))
		directional_light.light_energy = 1.0
	elif game_time >= DUSK_START and game_time < NIGHT_START: #Dusk
		var phase_progress = (game_time - DUSK_START) / (NIGHT_START - DUSK_START)
		directional_light.light_color = Color(DAY_COLOR.lerp(NIGHT_COLOR, phase_progress))
		directional_light.light_energy = 1.0
	else:  # Nighttime
		directional_light.light_color = Color(0.5, 0.5, 1.0)
		directional_light.light_energy = 0.4
	
