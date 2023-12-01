extends TileMap

@onready var globalVariables = get_node("/root/DaleAutoload")

# We need to assign our interaction sprites to variables.
@onready var exitInteract = $ExitArea2D/Sprite2D
@onready var exitAnimate = $ExitArea2D/AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	globalVariables.currentScene = "witchHouse"
	get_tree().paused = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


# This makes our interact icon show up or dissapear.
func _on_exit_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		exitInteract.show()
		exitAnimate.play("interact")
		globalVariables.currentInteraction = "witchExit"
		globalVariables.overworldStart = Vector2(287, 50)


func _on_exit_area_2d_body_exited(body):
	if body.is_in_group("Player"):
		exitInteract.hide()
		exitAnimate.stop()
		globalVariables.currentInteraction = ""
