extends CharacterBody2D

# Physics variables.
@export var speed = 300.0
@export var jumpVelocity = -600
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# We need our gameplay variables.
@export var health = 3

# We need access to our global Dale variables for positioning
@onready var playerVars = get_node("/root/DaleAutoload") 

# Animation variables.
var state = "idle"
var direction = 1

# Behaviour variables.
var aware = false
var enemyPosition = position
var relativePositionX = ""
var relativePositionY = ""

# We need access to our animations.
@onready var animations = $AnimationPlayer

# We need the invincibility timer.
@onready var invincibilityTimer = $InvincibilityTimer

# We need to access the hit box of the enemy to turn it off for invincibility.
@onready var hitBox = $DamageArea2D

# We need to grab our sprite to flip it.
@onready var sprite = $Sprite2D


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# This section makes the enemy move. This will move faster if they detect the player.
	if state != "attacked":
		if aware == false:
			velocity.x = speed * direction
		if aware == true:
			velocity.x = speed * 1.5 * direction
	
	# We want the enemy to jump if they're stuck on a wall.
	if is_on_wall() && state != "jumping":
		velocity.y = jumpVelocity

	move_and_slide()
	
	
	# We need to update our enemy position variable.
	enemyPosition = position
	
	# This makes the enemy follow the player. This is also used to track the position relative to the player for knockback.
	if aware == true:
		if enemyPosition.x > playerVars.dalePosition.x:
			direction = -1
			relativePositionX = "right"
		elif enemyPosition.x < playerVars.dalePosition.x:
			direction = 1
			relativePositionX = "left"

	# We are also going to track the relative position to see if the enemy is higher than the player.
	if enemyPosition.y > playerVars.dalePosition.y:
		relativePositionY = "below"
	elif enemyPosition.y < playerVars.dalePosition.y:
		relativePositionY = "above"


	# To track the enemy's state.
	if not is_on_floor() && state != "attacked":
		state = "jumping"
	elif state != "attacked":
		state = "walking"

	# Going to track if the player is attacking to see if we can make it so the enemy only picks up the damage at that time.
	if playerVars.attacking == true:
		hitBox.monitoring = true
	else:
		hitBox.monitoring = false


	# This will control the enemy's animations.
	if health <= 0:
		pass
	elif state == "attacked":
		animations.play("damaged")
	else:
		if aware == true:
			animations.play("angry_walk")
		if aware == false:
			animations.play("walk")

	# This will tell the enemy what direction to face.
	if direction == 1:
		sprite.set_flip_h(true)
	if direction == -1:
		sprite.set_flip_h(false)


	# Lastly we need to check if the enemy is dead.
	if health <= 0:
		animations.play("death")


# This will tell us if the enemy sees the player.
func _on_detection_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		aware = true

func _on_detection_area_2d_body_exited(body):
	if body.is_in_group("Player"):
		aware = false


# This makes it so the player can damage the enemy and knock them back.
func _on_damage_area_2d_area_entered(area):
	if area.is_in_group("Attack"):
		health -= playerVars.damage
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


# Resets the enemy after an attack.
func _on_invincibility_timer_timeout():
	state = "idle"

# This affects our knockback.
func _on_attack_area_2d_body_entered(body):
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


# This gets rid of the enemy after the death animation.
func _on_animation_player_animation_finished(anim_name):
	if anim_name == "death":
		queue_free()


# This flips the enemy movement periodically. 
func _on_movement_timer_timeout():
	direction = direction * -1
