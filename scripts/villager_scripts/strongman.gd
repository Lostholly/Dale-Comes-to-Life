extends Area2D

@onready var animation = $AnimationPlayer
@onready var interact = $InteractSprite
@onready var interactAnimation = $InteractSprite/AnimationPlayer

@onready var globalVariables = get_node("/root/DaleAutoload")


# Called when the node enters the scene tree for the first time.
func _ready():
	animation.play("normal")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_body_entered(body):
	if body.is_in_group("Player"):
		interact.show()
		interactAnimation.play("interact")
		globalVariables.currentInteraction = "strongman"


func _on_body_exited(body):
	if body.is_in_group("Player"):
		interact.hide()
		interactAnimation.stop()
		globalVariables.currentInteraction = ""
