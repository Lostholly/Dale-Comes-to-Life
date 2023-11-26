extends Node

# Gameplay variables.
@export var health = 10
@export var maxHealth = 10
@export var damage = 1

# Motion variables. Tracks the player's position for enemy behaviour. The knockback variable moves Dale when attacked.
var dalePosition = Vector2()
var knockback = Vector2()

# We need this one lone behaviour variable so enemies can detect if Dale is attacking.
var attacking = false


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
