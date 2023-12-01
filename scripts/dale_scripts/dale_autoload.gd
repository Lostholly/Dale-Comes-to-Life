extends Node

# Gameplay variables.
var health = 10
var maxHealth = 10
var damage = 1

# Motion variables. Tracks the player's position for enemy behaviour. The knockback variable moves Dale when attacked.
var dalePosition = Vector2()
var knockback = Vector2()

# We need this one lone behaviour variable so enemies can detect if Dale is attacking.
var attacking = false

# This variable will control the camera for Dale. It will adjust the bounds based on where he is. It will also control the music..
var currentScene = "village"

# This variable will set the current dialogue or interaction for dale.
var currentInteraction = ""

# This variable will pass dialogue from villagers and signs to Dale's UI.
var dialogue = ""

# We need to track our start position in the overworld.
var overworldStart = Vector2()

# We also need to track our position in certain sideview zones.
var sideviewStart = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
# This short script ensures that health never goes below 0 or above max health.
	if health > maxHealth:
		health = maxHealth
	elif health < 0:
		health = 0
