extends Node

# This is to track player health.
var health = 10
var maxHealth = 10

# Creating a damage variable for later.
var damage = 1

# This is to determine enemy behaviour.
var location = 0

# This variable will affect our knockback. Enemies will change it when they collide with the player.
var knockback = Vector2()

# I want to make a state machine to control animations and knockback amongst other things.
var state = "idle"


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
		
