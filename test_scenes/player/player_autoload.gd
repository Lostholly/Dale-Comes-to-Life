extends Node

# This is to track player health.
var health = 10
var maxHealth = 10

# Creating a damage variable for later.
var damage = 1

# This is to determine enemy behaviour.
var location = Vector2()

# This variable will affect our knockback power.
var knockback = Vector2()

# THESE TWO VARIABLES DO NOT NEED TO BE LOADED HERE. YOU CAN PUT THEM IN THE PLAYER SCRIPT.
# I want to make a state machine to control animations and knockback amongst other things.
var state = "idle"

# This will track what direction the player is facing for animation purposes.
var facing = "right"

# We need a variable to determine if the character is attacking for collision and animation purposes.
var attacking = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
# We need to make sure our health stays below the max and above 0.
	if health > maxHealth:
		health = maxHealth
	elif health < 0:
		health = 0
		
