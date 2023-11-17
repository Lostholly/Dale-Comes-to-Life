extends CharacterBody2D

# Our constants for movement speed and jump velocity.
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# We need our direction so we can change it without keyboard input. This is also used for animations.
var direction = 1

# Here we will define a jump
func enemy_jump():
	velocity.y = JUMP_VELOCITY
	
# We need to access our global variables.
@onready var playerVars = get_node("/root/PlayerAutoload")

# We also need our enemy position.
var enemyPosition = position

# We need a relative variable to determine the position of the enemy compared to the player as well.
var relativePosition = ""

# We need our variables for animations.
var state = "idle"

# We need a state to check if the enemy can see the player.
var aware = false


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	velocity.x = direction * SPEED
	
	# We need to update our position variable for any of this to work at all.
	enemyPosition = position

	move_and_slide()
	
	# This makes the enemy follow the player. This is also used to track the position relative to the player for knockback.
	if aware == true:
		if enemyPosition.x > playerVars.location:
			direction = -1
			relativePosition = "right"
		elif enemyPosition.x < playerVars.location:
			direction = 1
			relativePosition = "left"
	
	if aware == false && is_on_wall():
		direction = -direction
		
	# We need to track if buddy is in the air or not.
	if not is_on_floor():
		state = "jumping"
	else:
		state = "walking"
	
	print(relativePosition)




	# This timer should periodically trigger a jump from the enemy. 
func _on_enemy_timer_timeout():
	if is_on_floor():
		enemy_jump()
	else:
		pass

	# This will control our knockback.
func _on_enemy_attack_radius_body_entered(body):
	pass
	#if body.is_in_group("Player"):
	#	var X = 0.0
	#	var Y = 0.0
	#	playerVars.knockbackPower = Vector2(X, Y)

	# This will control if the enemy sees the player.
func _on_enemy_detection_radius_body_entered(body):
	if body.is_in_group("Player"):
		aware = true

func _on_enemy_detection_radius_body_exited(body):
	if body.is_in_group("Player"):
		aware = false
