extends CharacterBody2D

# Motion/physics variables.
@export var speed = 600.0
@export var jumpVelocity = -900.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# We have to call our global variables as variable for various processes.
@onready var globalVariables = get_node("/root/DaleAutoload")

# Behaviour variables to determine things like invincibility frames and animations.
@onready var animations = $AnimationPlayer
@onready var invincibilityTimer = $InvincibilityTimer
@onready var attackTimer = $AttackTimer
@onready var attackDirection = $AttackArea2D/AttackShape2D
var state = "idle"
var facing = "right"

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# This section deals with jumping.
	if state != "attacked":
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = jumpVelocity
	
	# This gives us variable jumping heights by capping the height when the jump button is released.
	if Input.is_action_just_released("jump"):
		if velocity.y < -250:
			velocity.y = -250
	
	# This sets our jump state.
	if not is_on_floor() && state != "attacked":
		state = "jumping"
	if state == "jumping" && is_on_floor():
		state = "idle"


	# This is our walking section. The code below makes the player move when A or D (or the arrow keys) are pressed.
	if state != "attacked":
		if Input.is_action_pressed("walk_left") && Input.is_action_pressed("walk_right"):
			velocity.x = 0
			if state != "jumping":
				state = "walking"
		elif Input.is_action_pressed("walk_left"):
			velocity.x = -speed
			if state != "jumping":
				state = "walking"
		elif Input.is_action_pressed("walk_right"):
			velocity.x = speed
			if state != "jumping":
				state = "walking"

	# We need to track our direction for animation purposes.
	if Input.is_action_just_pressed("walk_left"):
		facing = "left"
	if Input.is_action_just_pressed("walk_right"):
		facing = "right"
		
	# Finally, we need to reset our idle animation after jumping or moving.
	if Input.is_action_just_released("walk_left") || Input.is_action_just_released("walk_right"):
		velocity.x = 0
		if state != "jumping":
			state = "idle"


	# This is our attacking section. This monstrosity controls our attack animations.
	if state != "attacked":
		if Input.is_action_just_pressed("attack") and globalVariables.attacking == false:
			globalVariables.attacking = true
			attackTimer.start()
			if facing == "left":
				if state == "jumping":
					if Input.is_action_pressed("up"):
						animations.play("jump_attack_up_left")
					elif Input.is_action_pressed("down"):
						animations.play("jump_attack_down_left")
					else:
						animations.play("jump_attack_left")
				else:
					if Input.is_action_pressed("up"):
						animations.play("attack_up_left")
					else:
						animations.play("attack_left")
			if facing == "right":
				if state == "jumping":
					if Input.is_action_pressed("up"):
						animations.play("jump_attack_up_right")
					elif Input.is_action_pressed("down"):
						animations.play("jump_attack_down_right")
					else:
						animations.play("jump_attack_right")
				else:
					if Input.is_action_pressed("up"):
						animations.play("attack_up_right")
					else:
						animations.play("attack_right")

	# Here lets set up our attack direction by changing the position of the attack shape node.
	if Input.is_action_pressed("up"):
		attackDirection.position = Vector2(-1, -33)
	elif Input.is_action_pressed("down") && state == "jumping":
		attackDirection.position = Vector2(-1, 33)
	elif facing == "left":
		attackDirection.position = Vector2(-25, 1)
	elif facing == "right":
		attackDirection.position = Vector2(25, 1)


	# This is our animation section. It controls the animation based on state and direction.
	if globalVariables.attacking == false:
		if state == "idle":
			if facing == "left":
				animations.play("idle_left")
			if facing == "right":
				animations.play("idle_right")
		elif state == "walking":
			if facing == "left":
				animations.play("run_left")
			if facing == "right":
				animations.play("run_right")
		elif state == "jumping":
			if facing == "left":
				animations.play("jump_left")
			if facing == "right":
				animations.play("jump_right")
		elif state == "attacked":
			if facing == "left":
				animations.play("damaged_left")
			if facing == "right":
				animations.play("damaged_right")

	# This function makes the physics work.
	move_and_slide()

	# Need to update position variable. This must go after move_and_slide.
	globalVariables.dalePosition = position

# Triggers damage on Dale and starts an invincibility timer.
func _on_damage_area_2d_body_entered(body):
	if body.is_in_group("Enemy") && state != "attacked" && globalVariables.attacking == false:
		globalVariables.health -= 1
		velocity = globalVariables.knockback
		state = "attacked"
		invincibilityTimer.start()

# This makes it so the enemy can't deal damage constantly. Gives an invincibility cooldown.
func _on_invincibility_timer_timeout():
	velocity.x = 0
	state = "idle"

# This gives us a bounce effect when we hit an enemy from above.
func _on_attack_area_2d_body_entered(body):
	if body.is_in_group("Enemy") && globalVariables.attacking == true && Input.is_action_pressed("down"):
		velocity.y = -600

# This makes it so attacking has a cooldown.
func _on_attack_timer_timeout():
	globalVariables.attacking = false
