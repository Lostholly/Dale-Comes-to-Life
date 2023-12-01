extends Node2D

# We need to reset all variables.
@onready var globalVariables = get_node("/root/DaleAutoload")

# Called when the node enters the scene tree for the first time.
func _ready():
	globalVariables.currentScene = "title"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_title_menu_button_pressed():
	globalVariables.maxHealth = 10
	globalVariables.damage = 1
	globalVariables.treasuresFound = 0
	globalVariables.hasBeet = false
	globalVariables.hasScales = false
	globalVariables.hasTears = false
	globalVariables.healthBuffed = false
	get_tree().change_scene_to_file("res://scenes/ui_scenes/title_menu.tscn")
