extends TileMap

@onready var globalVariables = get_node("/root/DaleAutoload")

# We need to assign our interaction sprites to variables.
@onready var exitInteract = $ExitArea2D/Sprite2D
@onready var exitAnimate = $ExitArea2D/AnimationPlayer
@onready var tutorialInteract = $EntranceArea/Sprite2D
@onready var tutorialAnimate = $EntranceArea/AnimationPlayer
@onready var sign1Interact = $village_sign1/Sprite2D
@onready var sign1Animate = $village_sign1/AnimationPlayer
@onready var sign2Interact = $village_sign2/Sprite2D
@onready var sign2Animate = $village_sign2/AnimationPlayer

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


func _on_entrance_area_area_entered(_area):
	tutorialInteract.show()
	tutorialAnimate.play("interact")
	globalVariables.currentInteraction = "tutorialEntrance"
	globalVariables.sideviewStart = Vector2(9801, 229)


func _on_entrance_area_area_exited(_area):
	tutorialInteract.hide()
	tutorialAnimate.stop()
	globalVariables.currentInteraction = ""


func _on_village_sign_1_body_entered(body):
	if body.is_in_group("Player"):
		sign1Interact.show()
		sign1Animate.play("interact")
		globalVariables.currentInteraction = "vSign1"


func _on_village_sign_1_body_exited(body):
	sign1Interact.hide()
	sign1Animate.stop()
	globalVariables.currentInteraction = ""


func _on_village_sign_2_body_entered(body):
	if body.is_in_group("Player"):
		sign2Interact.show()
		sign2Animate.play("interact")
		globalVariables.currentInteraction = "vSign2"


func _on_village_sign_2_body_exited(body):
	sign2Interact.hide()
	sign2Animate.stop()
	globalVariables.currentInteraction = ""
