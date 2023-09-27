extends CharacterBody3D

#@export creates variables that can be changed in the editor
#@onready creates variables that when the game is starting up

# Key Variables
@export var max_health = 100.0
@export var max_stamina = 100.0
@export var max_sanity = 100.0
@export var money = 0.0
var health = 0.0
var stamina = 0.0
var sanity = 0.0

# Movement variables
@export var speed = 2.0
var input_dir = Vector3()
var rotate_dir = Vector3()

# Animation Variables
@onready var animation_player = $Sprite3D/PlayerAnimation
@onready var area3D = $Interact
var direction = 1

# Interaction Variables
@export var interaction_range : float = 2.0
@onready var collision_shape = $Interact/CollisionShape3D




# FixedUpdate (_process() is Update)
func _physics_process(delta):
	get_movement(delta)
	# move_and_slide is similar to Unity's 'CharacterController.Move()'.
	move_and_slide()
	
func _input(event):
	if event.is_action_pressed("ui_interact"):
		interact()

# Start
func _ready():
	#any movement input will allow the character to be followed by the camera
	input_dir = -get_viewport().get_camera_3d().global_transform.basis.z
	input_dir.y = 0 #locks the y-axis so there's no floating or other funny business with gravity.  Keeps player grounded. 
	input_dir = input_dir.normalized()
	rotate_dir = input_dir.rotated(Vector3(0, 1, 0), deg_to_rad(90))
	
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
	
	var right_movement = rotate_dir * speed * h
	var upward_movement = input_dir * speed * v
	
	#tracks the direction the player is currently going toward
	velocity = (right_movement + upward_movement).normalized() * speed
	
	# If the player is moving, rotate the player to face the movement direction.
	# Similar to Unity's 'Transform.LookAt'.
	if velocity.length() > 0:
		var target_position = global_transform.origin + velocity.normalized()
		look_at(target_position, Vector3(0, 1, 0))
		
	get_animation(velocity.length(), v, h)

func get_animation(moving, v, h):
	
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
		
func interact():
	for body in area3D.get_overlapping_bodies():
		if body.is_in_group("npc"):
			body.talk()
			break
		elif body.is_in_group("door"):
			body._on_body_entered(self)
			break
		elif body.is_in_group("minigame"):
			body.is_fishing()
			break
