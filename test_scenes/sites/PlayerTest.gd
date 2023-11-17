extends CharacterBody2D

#These determine the jump velocity and movement speed
const SPEED = 600.0
const JUMP_VELOCITY = -900.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# I need to set the position of the player to a variable to determine enemy behaviour. To do so we must access our singleton.
@onready var playerVars = get_node("/root/PlayerAutoload")

# We need to set up our variable to trigger the invincibility timer.
@onready var invincibilityTimer = get_node("InvincibilityTimer")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# This gives us variable jumping heights by capping the height when the jump button is released.
	if Input.is_action_just_released("jump"):
		if velocity.y < -250:
			velocity.y = -250
	
	# This sets our jump state.
	if not is_on_floor() && playerVars.state != "attacked":
		playerVars.state = "jumping"
	if playerVars.state == "jumping" && is_on_floor():
		playerVars.state = "idle"
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
#	var direction = Input.get_axis("walk_left", "walk_right")
	
	# These make the player move when A or D (or the arrow keys) are pressed.
	if Input.is_action_pressed("walk_left") && Input.is_action_pressed("walk_right"):
		velocity.x = 0
		if playerVars.state != "jumping":
			playerVars.state = "walking"
	elif Input.is_action_pressed("walk_left"):
		velocity.x = -SPEED
		if playerVars.state != "jumping":
			playerVars.state = "walking"
	elif Input.is_action_pressed("walk_right"):
		velocity.x = SPEED
		if playerVars.state != "jumping":
			playerVars.state = "walking"
	
	# This sets the player back to the idle state after they stop moving and stops motion.
	if Input.is_action_just_released("walk_left") || Input.is_action_just_released("walk_right"):
		velocity.x = 0
		if playerVars.state != "jumping":
			playerVars.state = "idle"
	
	# We need to track our direction for animation purposes as well.
	if Input.is_action_just_pressed("walk_left"):
		playerVars.facing = "left"
	
	if Input.is_action_just_pressed("walk_right"):
		playerVars.facing = "right"
		
		
	#print(playerVars.health)


	move_and_slide()

	# Need to update position variable. This must go after move_and_slide.
	playerVars.location = position
	
	

	# This function is going to make it so whenever the player touches an enemy, their health goes down.
func _on_player_damage_radius_body_entered(body):
		if body.is_in_group("Enemy") && playerVars.state != "attacked":
			playerVars.health -= 1
			velocity = playerVars.knockback
			playerVars.state = "attacked"
			invincibilityTimer.start()
			

# Try using linear_interpolate() on the velocity here so it increases gradually. 
func _on_invincibility_timer_timeout():
	velocity.x = 0
	playerVars.state = "idle"
