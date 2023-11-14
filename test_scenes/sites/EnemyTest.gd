extends CharacterBody2D

# Our constants for movement speed and jump velocity.
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# We need to detect the location of the player and the location of the enemy so they will pursue the player.
var enemyLocation = position.x
var playerLocation = 0

# We need our direction so we can change it without keyboard input.
var direction = 1

# Here we will define a jump
func enemy_jump():
	velocity.y = JUMP_VELOCITY



func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	enemyLocation = position.x
	velocity.x = direction * SPEED
	
	print(is_on_wall())

	move_and_slide()
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if is_on_wall():
		direction *= -1
	#else
	#	velocity.x = move_toward(velocity.x, 0, SPEED)



	# This timer should periodically trigger a jump from the enemy. 
func _on_enemy_timer_timeout():
	if is_on_floor():
		enemy_jump()
	else:
		pass
