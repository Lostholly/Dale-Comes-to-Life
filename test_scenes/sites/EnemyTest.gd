extends CharacterBody2D

# Our constants for movement speed and jump velocity.
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Need enemy health.
var health = 3
const MAX_HEALTH = 3

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# We need our direction so we can change it without keyboard input. This is also used for animations.
var direction = 1

# Here we will define a jump
func enemy_jump():
	velocity.y = JUMP_VELOCITY
	
# We need to access our global variables.
@onready var playerVars = get_node("/root/DaleAutoload")

# We also need our enemy position.
var enemyPosition = position

# We need a relative variable to determine the position of the enemy compared to the player as well.
var relativePositionX = ""
var relativePositionY = ""

# We need our variables for animations.
var state = "idle"

# We need a state to check if the enemy can see the player.
var aware = false

# Need to get the timer node.
@onready var invincibilityTimer = $InvincibilityTimer

@onready var canEnemyBeHit = $EnemyHitBox

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if state != "attacked":
		velocity.x = direction * SPEED
	

	move_and_slide()

	# We need to update our position variable for any of this to work at all.
	enemyPosition = position
	
	# This makes the enemy follow the player. This is also used to track the position relative to the player for knockback.
	if aware == true:
		if enemyPosition.x > playerVars.dalePosition.x:
			direction = -1
			relativePositionX = "right"
		elif enemyPosition.x < playerVars.dalePosition.x:
			direction = 1
			relativePositionX = "left"
	
	print(relativePositionX)
	
	# We are also going to track the relative position to see if the enemy is higher than the player.
	if enemyPosition.y > playerVars.dalePosition.y:
		relativePositionY = "below"
	elif enemyPosition.y < playerVars.dalePosition.y:
		relativePositionY = "above"
	
	if aware == false && is_on_wall():
		direction = -direction
		
	# We need to track if buddy is in the air or not.
	if not is_on_floor() && state != "attacked":
		state = "jumping"
	elif state != "attacked":
		state = "walking"
	
	# Going to track if the player is attacking to see if we can make it so the enemy only picks up the damage at that time.
	if playerVars.attacking == true:
		canEnemyBeHit.monitoring = true
	else:
		canEnemyBeHit.monitoring = false
	
	# Need to create a default bit of script for watching health and keeping it in bounds.
	if health > MAX_HEALTH:
		health = MAX_HEALTH
	if health <= 0:
		health = 0
		queue_free()


	# This timer should periodically trigger a jump from the enemy. 
func _on_enemy_timer_timeout():
	if is_on_floor():
		enemy_jump()
	else:
		pass

	# This will control our knockback.
func _on_enemy_attack_radius_body_entered(body):
	if body.is_in_group("Player"):
		if playerVars.attacking == false:
			if relativePositionY == "above":
				if relativePositionX == "right":
					playerVars.knockback = Vector2(-500, 500)
				if relativePositionX == "left":
					playerVars.knockback = Vector2(500, 500)
			if relativePositionY == "below":
				if relativePositionX == "right":
					playerVars.knockback = Vector2(-500, -500)
				if relativePositionX == "left":
					playerVars.knockback = Vector2(500, -500)


	# This will control if the enemy sees the player.
func _on_enemy_detection_radius_body_entered(body):
	if body.is_in_group("Player"):
		aware = true

func _on_enemy_detection_radius_body_exited(body):
	if body.is_in_group("Player"):
		aware = false

func _on_invincibility_timer_timeout():
	state = "idle"

# Trying to detect the attack collison here.
func _on_enemy_hit_box_area_entered(area):
	if area.is_in_group("Attack"):
		print(health)
		health -= 1
		state = "attacked"
		invincibilityTimer.start()
		if relativePositionY == "above":
			if relativePositionX == "right":
				velocity = Vector2(500, -500)
			if relativePositionX == "left":
				velocity = Vector2(-500, -500)
		if relativePositionY == "below":
			if relativePositionX == "right":
				velocity = Vector2(500, 500)
			if relativePositionX == "left":
				velocity = Vector2(-500, 500)
