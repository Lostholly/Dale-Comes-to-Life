extends Area2D

@onready var animations = $AnimationPlayer
@onready var globalVariables = $"/root/DaleAutoload"

# Called when the node enters the scene tree for the first time.
func _ready():
	animations.play("normal")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if globalVariables.hasTears == true:
		queue_free()


func _on_body_entered(body):
	if body.is_in_group("Player"):
		globalVariables.hasTears = true
		globalVariables.treasuresFound += 1
		queue_free()
