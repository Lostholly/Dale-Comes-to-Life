extends TileMap

@onready var globalVariables = get_node("/root/DaleAutoload")

# We need to assign our interaction sprites to variables.
@onready var exitInteract = $ExitArea2D/Sprite2D
@onready var exitAnimate = $ExitArea2D/AnimationPlayer

# We need to assign our signs to variables.
@onready var sign1Interact = $TutorialSign1/Sprite2D
@onready var sign2Interact = $TutorialSign2/Sprite2D
@onready var sign3Interact = $TutorialSign3/Sprite2D
@onready var sign4Interact = $TutorialSign4/Sprite2D
@onready var sign5Interact = $TutorialSign5/Sprite2D
@onready var sign6Interact = $TutorialSign6/Sprite2D
@onready var sign7Interact = $TutorialSign7/Sprite2D
@onready var sign8Interact = $TutorialSign8/Sprite2D

@onready var sign1Animate = $TutorialSign1/AnimationPlayer
@onready var sign2Animate = $TutorialSign2/AnimationPlayer
@onready var sign3Animate = $TutorialSign3/AnimationPlayer
@onready var sign4Animate = $TutorialSign4/AnimationPlayer
@onready var sign5Animate = $TutorialSign5/AnimationPlayer
@onready var sign6Animate = $TutorialSign6/AnimationPlayer
@onready var sign7Animate = $TutorialSign7/AnimationPlayer
@onready var sign8Animate = $TutorialSign8/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	globalVariables.currentScene = "tutorial"
	get_tree().paused = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


# This makes our interact icon show up or dissapear.
func _on_exit_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		exitInteract.show()
		exitAnimate.play("interact")
		globalVariables.currentInteraction = "tutorialExit"
		globalVariables.sideviewStart = Vector2(-1681, 613)


func _on_exit_area_2d_body_exited(body):
	if body.is_in_group("Player"):
		exitInteract.hide()
		exitAnimate.stop()
		globalVariables.currentInteraction = ""


# This triggers our dialogue for each sign
func _on_tutorial_sign_1_body_entered(body):
	if body.is_in_group("Player"):
		sign1Interact.show()
		sign1Animate.play("interact")
		globalVariables.currentInteraction = "tSign1"


func _on_tutorial_sign_1_body_exited(body):
	if body.is_in_group("Player"):
		sign1Interact.hide()
		sign1Animate.stop()
		globalVariables.currentInteraction = ""


func _on_tutorial_sign_2_body_entered(body):
	if body.is_in_group("Player"):
		sign2Interact.show()
		sign2Animate.play("interact")
		globalVariables.currentInteraction = "tSign2"


func _on_tutorial_sign_2_body_exited(body):
	if body.is_in_group("Player"):
		sign2Interact.hide()
		sign2Animate.stop()
		globalVariables.currentInteraction = ""


func _on_tutorial_sign_3_body_entered(body):
	if body.is_in_group("Player"):
		sign3Interact.show()
		sign3Animate.play("interact")
		globalVariables.currentInteraction = "tSign3"


func _on_tutorial_sign_3_body_exited(body):
	if body.is_in_group("Player"):
		sign3Interact.hide()
		sign3Animate.stop()
		globalVariables.currentInteraction = ""


func _on_tutorial_sign_4_body_entered(body):
	if body.is_in_group("Player"):
		sign4Interact.show()
		sign4Animate.play("interact")
		globalVariables.currentInteraction = "tSign4"


func _on_tutorial_sign_4_body_exited(body):
	if body.is_in_group("Player"):
		sign4Interact.hide()
		sign4Animate.stop()
		globalVariables.currentInteraction = ""


func _on_tutorial_sign_5_body_entered(body):
	if body.is_in_group("Player"):
		sign5Interact.show()
		sign5Animate.play("interact")
		globalVariables.currentInteraction = "tSign5"


func _on_tutorial_sign_5_body_exited(body):
	if body.is_in_group("Player"):
		sign5Interact.hide()
		sign5Animate.stop()
		globalVariables.currentInteraction = ""


func _on_tutorial_sign_6_body_entered(body):
	if body.is_in_group("Player"):
		sign6Interact.show()
		sign6Animate.play("interact")
		globalVariables.currentInteraction = "tSign6"


func _on_tutorial_sign_6_body_exited(body):
	if body.is_in_group("Player"):
		sign6Interact.hide()
		sign6Animate.stop()
		globalVariables.currentInteraction = ""


func _on_tutorial_sign_7_body_entered(body):
	if body.is_in_group("Player"):
		sign7Interact.show()
		sign7Animate.play("interact")
		globalVariables.currentInteraction = "tSign7"


func _on_tutorial_sign_7_body_exited(body):
	if body.is_in_group("Player"):
		sign7Interact.hide()
		sign7Animate.stop()
		globalVariables.currentInteraction = ""


func _on_tutorial_sign_8_body_entered(body):
	if body.is_in_group("Player"):
		sign8Interact.show()
		sign8Animate.play("interact")
		globalVariables.currentInteraction = "tSign8"


func _on_tutorial_sign_8_body_exited(body):
	if body.is_in_group("Player"):
		sign8Interact.hide()
		sign8Animate.stop()
		globalVariables.currentInteraction = ""
