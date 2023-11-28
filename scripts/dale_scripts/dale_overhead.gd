extends CharacterBody2D

# Our movement speed.
const SPEED = 200.0

# We need to control our direction as well as if we are moving.
var moving = true
var direction = "right"

# We need to get our animations onto a variable.
@onready var animations = $AnimationPlayer


func _physics_process(_delta):

	if direction == "right":
		rotation_degrees = 90
	if direction == "left":
		rotation_degrees = 270
	if direction == "up":
		rotation_degrees = 0
	if direction == "down":
		rotation_degrees = 180

	if Input.is_action_pressed("walk_right"):
		moving = true
		direction = "right"
	elif Input.is_action_pressed("walk_left"):
		moving = true
		direction = "left"
	elif Input.is_action_pressed("up"):
		moving = true
		direction = "up"
	elif Input.is_action_pressed("down"):
		moving = true
		direction = "down"
	else:
		moving = false

	if moving == true:
		animations.play("walking")
		if direction == "right":
			velocity.x = SPEED
			velocity.y = 0
		elif direction == "left":
			velocity.x = -SPEED
			velocity.y = 0
		elif direction == "up":
			velocity.y = -SPEED
			velocity.x = 0
		elif direction == "down":
			velocity.y = SPEED
			velocity.x = 0
	else:
		velocity = Vector2(0,0)
		animations.play("RESET")

	move_and_slide()
