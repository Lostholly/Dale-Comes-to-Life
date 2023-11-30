extends Node2D

# We need to set our scene, set our music, and make Dale animated.
@onready var globalVariables = get_node("/root/DaleAutoload")
@onready var animation = $DaleSprite/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	globalVariables.currentScene = "title"
	animation.play("title_screen")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
