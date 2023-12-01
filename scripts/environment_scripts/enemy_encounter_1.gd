extends TileMap


@onready var globalVariables = get_node("/root/DaleAutoload")

# Called when the node enters the scene tree for the first time.
func _ready():
	globalVariables.currentScene = "enemyEncounter1"
	get_tree().paused = false

# We need to assign our interaction sprites to variables.
@onready var exitInteract = $ExitArea2D/Sprite2D
@onready var exitAnimate = $ExitArea2D/AnimationPlayer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_exit_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		exitInteract.show()
		exitAnimate.play("interact")
		globalVariables.currentInteraction = "enemy1Exit"
		globalVariables.overworldStart = Vector2(844, 67)


func _on_exit_area_2d_body_exited(body):
	if body.is_in_group("Player"):
		exitInteract.hide()
		exitAnimate.stop()
		globalVariables.currentInteraction = ""
