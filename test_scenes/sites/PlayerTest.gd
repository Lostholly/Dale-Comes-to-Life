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

# Likewise for the attack cooldown.
@onready var attackTimer = get_node("AttackTimer")

# We need to assign our animation controller to a variable.
@onready var animations = $PlayerSprite/PlayerAnimations

# We need to grab out collisions.
@onready var attackLeft = $AttackCollisionLeft
@onready var attackRight = $AttackCollisionRight
@onready var attackUp = $AttackCollisionUp
@onready var attackDown = $AttackCollisionDown

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if playerVars.state != "attacked":
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
	
	# These make the player move when A or D (or the arrow keys) are pressed.
	if playerVars.state != "attacked":
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
		
	# Alright, let's set up our attacks.
	if playerVars.state != "attacked":
		if Input.is_action_just_pressed("attack") and playerVars.attacking == false:
			playerVars.attacking = true
			attackTimer.start()
			if playerVars.facing == "left":
				if Input.is_action_pressed("up"):
					animations.play("attack_up_left")
					attackUp.monitorable = true
				elif Input.is_action_pressed("down") and playerVars.state == "jumping":
					animations.play("attack_down_left")
					attackDown.monitorable = true
				else:
					animations.play("attack_left")
					attackLeft.monitorable = true
			if playerVars.facing == "right":
				if Input.is_action_pressed("up"):
					animations.play("attack_up_right")
					attackUp.monitorable = true
				elif Input.is_action_pressed("down") and playerVars.state == "jumping":
					animations.play("attack_down_right")
					attackDown.monitorable = true
				else:
					animations.play("attack_right")
					attackRight.monitorable = true
					
	# We have to make it so our attack collisions dissapear after the attack.
	if playerVars.attacking == false:
		attackLeft.monitorable = false
		attackRight.monitorable = false
		attackUp.monitorable = false
		attackDown.monitorable = false
		
	# This is the animation section. This will use the facing and state playerVars.
	if playerVars.attacking == false:
		if playerVars.state == "idle":
			if playerVars.facing == "left":
				animations.play("idle_left")
			if playerVars.facing == "right":
				animations.play("idle_right")
		elif playerVars.state == "walking":
			if playerVars.facing == "left":
				animations.play("walk_left")
			if playerVars.facing == "right":
				animations.play("walk_right")
		elif playerVars.state == "jumping":
			if playerVars.facing == "left":
				animations.play("jump_left")
			if playerVars.facing == "right":
				animations.play("jump_right")
		elif playerVars.state == "attacked":
			if playerVars.facing == "left":
				animations.play("damaged_left")
			if playerVars.facing == "right":
				animations.play("damaged_right")


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

func _on_attack_timer_timeout():
	playerVars.attacking = false

# We want to make it so we can bounce on the enemy. 
func _on_attack_collision_down_body_entered(body):
	if body.is_in_group("Enemy"):
		velocity.y = -600
