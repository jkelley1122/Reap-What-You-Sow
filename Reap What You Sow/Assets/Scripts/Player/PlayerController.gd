extends CharacterBody3D

#@export creates variables that can be changed in the editor
#@onready creates variables that when the game is starting up

# Key Variables
@export var max_health = 100.0
@export var max_stamina = 100.0
@export var max_sanity = 100.0
@export var money = 0.0
var health = max_health
var stamina = max_stamina
var sanity = max_sanity

# Movement variables
@export var speed = 2.0
var input_dir = Vector3()
var rotate_dir = Vector3()

# Animation Variables
@onready var animation_player = $Sprite3D/PlayerAnimation
@onready var area3D = $Interact
var direction = 1


# Interaction Variables
@export var interaction_range : float = 0.6
@onready var collision_shape = $Interact/CollisionShape3D
enum State {
	Default,
	Transition, # Used for when the input is giving you troubles
	Talking,
	Fishing
}
var current_state = State.Default

var is_sleeping = false;

# Inventory Variables
@onready var inventory = $Inventory
@onready var seeds_pouch = $SeedsPouch

var cur_item = null
var starting_items = {
	"Hoe": 1,
	"Fishing Pole": 1,
}

var seeds = {
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
# HUD Variables
@onready var HUD = $HUD
@onready var input_sprite = $InputSprite

# FixedUpdate (_process() is Update)
func _physics_process(delta):
	get_movement(delta)
	if can_interact():
		input_sprite.visible = true
	else:
		input_sprite.visible = false
	# move_and_slide is similar to Unity's 'CharacterController.Move()'.
	move_and_slide()
	
	
func _input(event):
	if event.is_action_pressed("ui_interact"):
		interact()
	if event.is_action_pressed("debug_gain_sanity"):
		sanity += 5
	if event.is_action_pressed("debug_lose_sanity"):
		sanity -= 5
		
	GameController.player_sanity = sanity

# Start
func _ready():
	#any movement input will allow the character to be followed by the camera
	input_dir = -get_viewport().get_camera_3d().global_transform.basis.z
	input_dir.y = 0 #locks the y-axis so there's no floating or other funny business with gravity.  Keeps player grounded. 
	input_dir = input_dir.normalized()
	rotate_dir = input_dir.rotated(Vector3(0, 1, 0), deg_to_rad(90))
	# Adding items to the inventory.
	inventory.inventory = GameController.player_inventory
	seeds_pouch.inventory = GameController.player_seeds
	
	# Set Interact's collision shape's radius to what's in the editor
	if collision_shape and collision_shape.shape:
		collision_shape.shape.radius = interaction_range
	else:
		print("The player does not have an interaction collider!")

func get_movement(delta):
	#h and v (previously direction) is what acquires the input from the keyboard. Godot default uses rebindable keys
	# Rebindable keys can be found in Project -> Project Settings -> Input Map
	# Similar to Unity's Input.GetAxis but returns a value between 0 and 1.
	var h = Input.get_action_strength("ui_left") - Input.get_action_strength("ui_right")
	var v = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
	if current_state == State.Default:
		var right_movement = rotate_dir * speed * h
		var upward_movement = input_dir * speed * v
		
		#tracks the direction the player is currently going toward
		velocity = (right_movement + upward_movement).normalized() * speed
		
		# If the player is moving, rotate the player to face the movement direction.
		# Similar to Unity's 'Transform.LookAt'.
		if velocity.length() > 0:
			var target_position = global_transform.origin + velocity.normalized()
			look_at(target_position, Vector3(0, 1, 0))
	else:
		velocity = Vector3.ZERO
	
	get_animation(velocity.length(), v, h)

func get_animation(moving, v, h):
	if current_state == State.Default || current_state == State.Talking:
		if moving > 0:
			if v < 0:
				if h < 0:
					animation_player.play("walk_FR")
					direction = 6
				elif h > 0:
					animation_player.play("walk_FL")
					direction = 5
				else:
					animation_player.play("walk_forward")
					direction = 1
			elif v > 0:
				if h < 0:
					animation_player.play("walk_BR")
					direction = 8
				elif h > 0:
					animation_player.play("walk_BL")
					direction = 7
				else:
					animation_player.play("walk_back")
					direction = 4
			else:
				if h < 0:
					animation_player.play("walk_right")
					direction = 3
				elif h > 0:
					animation_player.play("walk_left")
					direction = 2
		else:
			match direction:
				1:
					animation_player.play("idle_forward")
				2:
					animation_player.play("idle_left")
				3:
					animation_player.play("idle_right")
				4:
					animation_player.play("idle_back")
				5:
					animation_player.play("idle_FL")
				6:
					animation_player.play("idle_FR")
				7:
					animation_player.play("idle_BL")
				8:
					animation_player.play("idle_BR")
				_:
					animation_player.play("idle_forward")
	elif current_state == State.Fishing:
		match direction:
				1:
					animation_player.play("fish_forward") ###CHANGE THESE LATER###
				2:
					animation_player.play("fish_forward") #fish_left
				3:
					animation_player.play("fish_forward") #fish_right
				4:
					animation_player.play("fish_forward") #fish_back
				5:
					animation_player.play("fish_forward") #fish_fl
				6:
					animation_player.play("fish_forward") #fish_fr
				7:
					animation_player.play("fish_forward") #fish_bl
				8:
					animation_player.play("fish_forward") #fish_br
				_:
					animation_player.play("fish_forward") ###CHANGE THESE LATER###
		
func interact():
	if current_state == State.Default:
		for body in area3D.get_overlapping_bodies():
			if body.is_in_group("npc"):
				body.talk()
				if sanity <= 95:
					sanity += 5
				else:
					sanity = 100
				GameController.player_sanity = sanity
				current_state = State.Talking
				break
			elif body.is_in_group("door"):
				body._on_body_entered(self)
				break
			elif body.is_in_group("Planter"):
				body.harvest()
				break
			elif body.is_in_group("Shop_Buy"):
				body.buy()
				break
			elif body.is_in_group("Shop_Sell"):
				body.sell()
				break
			elif body.is_in_group("Bed"):
				is_sleeping = true
				break
		for body in area3D.get_overlapping_areas(): #check for if the player is in the trigger area
			if current_state == State.Default and cur_item == "Fishing Pole": #state change
				if body.is_in_group("minigame"):
					#current_state = State.Fishing
					body.setup_fishing(self)
					break
	elif current_state == State.Fishing: #resets state to default
		current_state = State.Default
	elif current_state == State.Transition:
		current_state = State.Default
				

func can_interact():
	for body in area3D.get_overlapping_bodies():
		if body.is_in_group("npc"):
			return true
		elif body.is_in_group("door"):
			return true
		elif body.is_in_group("Planter"):
			if body.stage == 4:
				return true
		elif body.is_in_group("Shop_Buy"):
			return true
		elif body.is_in_group("Shop_Sell"):
			return true
		elif body.is_in_group("Bed"):
			return true
			
	for body in area3D.get_overlapping_areas(): #check for if the player is in the trigger area
		if body.is_in_group("minigame") and cur_item == "Fishing Pole":
			return true
		elif body.is_in_group("minigame"):
			return false
	return false


func set_cur_item(item_name):
	cur_item = item_name
	GameController.player_item = cur_item

func set_cur_seed(seed_name):
	match(seed_name):
		'Corn Seeds':
			$FarmPlot.croptype = 0
		'Carrot Seeds':
			$FarmPlot.croptype = 1
		'Blackberry Seeds':
			$FarmPlot.croptype = 2
		'Raspberry Seeds':
			$FarmPlot.croptype = 3
		'Tobacco Seeds':
			$FarmPlot.croptype = 4
		'Broccoli Seeds':
			$FarmPlot.croptype = 5
		'Wheat Seeds':
			$FarmPlot.croptype = 6
		'Tomato Seeds':
			$FarmPlot.croptype = 7
		'Cauliflower Seeds':
			$FarmPlot.croptype = 8
	$FarmPlot.plants[$FarmPlot.croptype] = seed_name
	GameController.player_crop = seed_name
