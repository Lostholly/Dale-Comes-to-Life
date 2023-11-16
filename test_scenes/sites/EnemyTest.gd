extends CharacterBody2D

# Our constants for movement speed and jump velocity.
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# We need our direction so we can change it without keyboard input.
var direction = 1

# Here we will define a jump
func enemy_jump():
	velocity.y = JUMP_VELOCITY
	
# We need to access our global variables.
@onready var playerVars = get_node("/root/PlayerAutoload")

# We also need our enemy position.
var enemyPosition = position.x


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	velocity.x = direction * SPEED
	
	# We need to update our position variable for any of this to work at all.
	enemyPosition = position.x

	move_and_slide()
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	# So this tells the enemy it's on a wall and makes it turn around.
	if enemyPosition > playerVars.playerLocation:
		direction = -1
	elif enemyPosition < playerVars.playerLocation:
		direction = 1



	# This timer should periodically trigger a jump from the enemy. 
func _on_enemy_timer_timeout():
	if is_on_floor():
		enemy_jump()
	else:
		pass
