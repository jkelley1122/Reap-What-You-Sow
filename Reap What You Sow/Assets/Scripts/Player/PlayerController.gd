extends CharacterBody3D

#movement variables
@export var speed = 3.0
var input_dir = Vector3()
var rotate_dir = Vector3()

# Interaction Variables
@export var interaction_range : float = 2.0
var interaction_layer : int = 1

# FixedUpdate (_process() is Update)
func _physics_process(delta):
	get_movement(delta)
	# move_and_slide is similar to Unity's 'CharacterController.Move()'.
	move_and_slide()
	
	if Input.is_action_just_pressed("ui_interact"):
		interact()

# Start
func _ready():
	#any movement input will allow the character to be followed by the camera
	input_dir = -get_viewport().get_camera_3d().global_transform.basis.z
	input_dir.y = 0 #locks the y-axis so there's no floating or other funny business with gravity.  Keeps player grounded. 
	input_dir = input_dir.normalized()
	rotate_dir = input_dir.rotated(Vector3(0, 1, 0), deg_to_rad(90))

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


	# Animation variable
	var animation_player = $Sprite3D/PlayerAnimation
	
	# If the player is moving, rotate the player to face the movement direction.
	# Similar to Unity's 'Transform.LookAt'.
	if velocity.length() > 0:
		var target_position = global_transform.origin + velocity.normalized()
		look_at(target_position, Vector3(0, 1, 0))
		
		# Animation calculation
		if v < 0:
			if h < 0:
				animation_player.play("walk_FR")
			elif h > 0:
				animation_player.play("walk_FL")
			else:
				animation_player.play("walk_forward")
		elif v > 0:
			if h < 0:
				animation_player.play("walk_BR")
			elif h > 0:
				animation_player.play("walk_BL")
			else:
				animation_player.play("walk_backward")
		else:
			if h < 0:
				animation_player.play("walk_right")
			elif h > 0:
				animation_player.play("walk_left")
	else:
		animation_player.play("idle_forward")

func interact():
	var interaction_shape = SphereShape3D.new()
	var shape_query = PhysicsShapeQueryParameters3D.new()
	shape_query.shape_rid = interaction_shape.get_rid()
	shape_query.transform = self.global_transform
	shape_query.collision_mask = interaction_layer

	var hits = get_world_3d().direct_space_state.intersect_shape(shape_query)
	
	for hit in hits:
		if hit.collider.is_in_group("NPC"):
			hit.collider.Talk()
		elif hit.collider.is_in_group("Door"):
			hit.collider.Enter()
