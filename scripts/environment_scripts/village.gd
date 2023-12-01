extends TileMap

@onready var globalVariables = get_node("/root/DaleAutoload")

# We need to assign our interaction sprites to variables.
@onready var exitInteract = $ExitArea2D/Sprite2D
@onready var exitAnimate = $ExitArea2D/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	globalVariables.currentScene = "village"
	get_tree().paused = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


# This makes our interact icon show up or dissapear.
func _on_exit_area_2d_area_entered(_area):
	exitInteract.show()
	exitAnimate.play("interact")
	globalVariables.currentInteraction = "villageExit"
	globalVariables.overworldStart = Vector2(211, 355)

func _on_exit_area_2d_area_exited(_area):
	exitInteract.hide()
	exitAnimate.stop()
	globalVariables.currentInteraction = ""
