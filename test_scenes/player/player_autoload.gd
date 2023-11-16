extends Node

# This is to track player health.
var health = 10
var maxHealth = 10

# This is to determine enemy behaviour.
var playerLocation = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
# We need to make sure our health stays below the max and above 0.
	if health > maxHealth:
		health = maxHealth
	elif health < 0:
		health = 0
