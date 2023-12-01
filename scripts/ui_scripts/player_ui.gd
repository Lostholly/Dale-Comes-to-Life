extends CanvasLayer

# We need our global variables to detect health and our music player to check volume. 
@onready var globalVariables = get_node("/root/DaleAutoload")
@onready var musicPlayer = get_node("/root/MusicPlayer")

# We need to assign our UI elements to variables.
@onready var healthBar = $HealthBar
@onready var deathScreen = $MenuControl/DeathScreen
@onready var mainMenu = $MenuControl/MainMenu
@onready var controls = $MenuControl/Controls
@onready var volumeControl = $MenuControl/VolumeControl
@onready var leaveMenu = $MenuControl/LeaveMapMenu
@onready var leaveText = $MenuControl/LeaveMapMenu/MarginContainer/VBoxContainer/CenterContainer/VBoxContainer/LeaveLabel
@onready var dialogueBox = $MenuControl/DialogueBox
@onready var dialogueText = $MenuControl/DialogueBox/MarginContainer/VBoxContainer/CenterContainer/VBoxContainer/DialogueLabel

# We need to be able to set our current volume on this scene so it doesn't constantly reset.
@onready var volumeSlider = $MenuControl/VolumeControl/MarginContainer/VBoxContainer/CenterContainer/VBoxContainer/VolumeSlider
var currentVolume = 1.0

# We need a simple boolean operator to make it so our interactions don't trigger infinitely.
var interacting = false

# Called when the node enters the scene tree for the first time.
func _ready():
# This will set our volume slider to the current volume when the scene loads.
	if musicPlayer.volume == -80:
		currentVolume = 0
	else:
		currentVolume = (musicPlayer.volume / 20) + 1
		volumeSlider.value = currentVolume


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# This function will control the animation of our health bar.
	healthBar.frame = 23 - globalVariables.health
	
	# This will trigger our death screen.
	if globalVariables.health == 0:
		deathScreen.show()
		get_tree().paused = true
		
	# We need to be able to open our menu.
	if Input.is_action_just_pressed("menu") && mainMenu.is_visible_in_tree() != true && controls.is_visible_in_tree() != true && volumeControl.is_visible_in_tree() != true && leaveMenu.is_visible_in_tree() != true && dialogueBox.is_visible_in_tree() != true:
		mainMenu.show()
		get_tree().paused = true
	elif Input.is_action_just_pressed("menu"):
		if mainMenu.is_visible_in_tree() == true || controls.is_visible_in_tree() == true || volumeControl.is_visible_in_tree() == true || leaveMenu.is_visible_in_tree() == true || dialogueBox.is_visible_in_tree() == true:
			mainMenu.hide()
			controls.hide()
			volumeControl.hide()
			leaveMenu.hide()
			dialogueBox.hide()
			get_tree().paused = false
			interacting = false
	
	
	# This section is dealing with exit interactions. It simply makes the dialogue box appear.
	if interacting == false:
		if Input.is_action_just_pressed("interact") && leaveMenu.is_visible_in_tree() == false:
			if globalVariables.currentInteraction == "villageExit" || globalVariables.currentInteraction == "enemy1Exit" || globalVariables.currentInteraction == "villageEntrance" || globalVariables.currentInteraction == "enemy1Entrance" || globalVariables.currentInteraction == "tutorialExit":
				leaveMenu.show()
				get_tree().paused = true
				interacting = true
	elif interacting == true:
		if Input.is_action_just_pressed("interact") && leaveMenu.is_visible_in_tree() == true:
			if globalVariables.currentInteraction == "villageExit" || globalVariables.currentInteraction == "enemy1Exit" || globalVariables.currentInteraction == "villageEntrance" || globalVariables.currentInteraction == "enemy1Entrance"|| globalVariables.currentInteraction == "tutorialExit":
				leaveMenu.hide()
				get_tree().paused = false
				interacting = false
	# I want to change the text of the leave button as well.
	if globalVariables.currentInteraction == "villageExit":
		leaveText.text = "Leave the village?"
	if globalVariables.currentInteraction == "enemy1Exit":
		leaveText.text = "Leave this place?"
	if globalVariables.currentInteraction == "villageEntrance":
		leaveText.text = "Enter the village?"
	if globalVariables.currentInteraction == "enemy1Entrance":
		leaveText.text = "Search for the beet?"
	if globalVariables.currentInteraction == "tutorialExit":
		leaveText.text = "Head to the village?"


	# This will control our dialogue text.
	if interacting == false:
		if Input.is_action_just_pressed("interact") && dialogueBox.is_visible_in_tree() == false:
			if globalVariables.currentInteraction == "tSign1" || globalVariables.currentInteraction == "tSign2" || globalVariables.currentInteraction == "tSign3" || globalVariables.currentInteraction == "tSign4" || globalVariables.currentInteraction == "tSign5"|| globalVariables.currentInteraction == "tSign6" || globalVariables.currentInteraction == "tSign7"|| globalVariables.currentInteraction == "tSign8":
				dialogueBox.show()
				get_tree().paused = true
				interacting = true
	elif interacting == true:
		if Input.is_action_just_pressed("interact") && dialogueBox.is_visible_in_tree() == true:
			if globalVariables.currentInteraction == "tSign1" || globalVariables.currentInteraction == "tSign2" || globalVariables.currentInteraction == "tSign3" || globalVariables.currentInteraction == "tSign4" || globalVariables.currentInteraction == "tSign5"|| globalVariables.currentInteraction == "tSign6" || globalVariables.currentInteraction == "tSign7"|| globalVariables.currentInteraction == "tSign8":
				dialogueBox.hide()
				get_tree().paused = false
				interacting = false

	# This section contains our text. It is formatted. 
	if globalVariables.currentInteraction == "tSign1":
		dialogueText.text = "Dale, 

You probably remember this but you can move with
WASD or the Arrow Keys.

- Dale


"
	if globalVariables.currentInteraction == "tSign2":
		dialogueText.text = "Dale, 

I'm writing this down so we don't forget again. You can 
jump by pressing the Spacebar.

- Dale


"
	if globalVariables.currentInteraction == "tSign3":
		dialogueText.text = "Dale, 

Our claws are mighty and we fear no creatures of the
earth. Use the left mouse button or Shift to strike.

- Dale


"
	if globalVariables.currentInteraction == "tSign4":
		dialogueText.text = "Dale, 

Our training has paid off. Hold W/Up while attacking to 
strike up, or S/Down while attacking in the air to strike
down.

- Dale

"
	if globalVariables.currentInteraction == "tSign5":
		dialogueText.text = "Dale, 

Some enemies may drop hearts after being defeated. 
Grab these to replenish your health. Tasty!

- Dale


"
	if globalVariables.currentInteraction == "tSign6":
		dialogueText.text = "Dale, 

We all need breaks sometimes. Press G or M to pause 
the game and open the menu.

- Dale


"
	if globalVariables.currentInteraction == "tSign7":
		dialogueText.text = "Dale, 

Sometimes we have to leave things unfinished. Remember
that you cannot save and if you close the game you'll 
have to start over.

- Dale

"
	if globalVariables.currentInteraction == "tSign8":
		dialogueText.text = "Dale, 

The village lies ahead. Be yourself and you'll make a good
impression. Talk to the villagers. I believe in you.

- Dale


"

# We need this to unpause the game and get rid of the menu.
func _on_return_button_pressed():
	mainMenu.hide()
	get_tree().paused = false


# Show and hide our controls.
func _on_controls_button_pressed():
	mainMenu.hide()
	controls.show()

func _on_controls_return_button_pressed():
	controls.hide()
	mainMenu.show()


func _on_volume_button_pressed():
	mainMenu.hide()
	volumeControl.show()

func _on_volume_return_pressed():
	volumeControl.hide()
	mainMenu.show()


# Our volume control function.
func _on_volume_slider_value_changed(value):
	if value == 0:
		musicPlayer.volume = -80.0
	else:
		musicPlayer.volume = -20 + (value * 20)


# Returns to main menu.
func _on_exit_button_pressed():
	get_tree().change_scene_to_file("res://scenes/ui_scenes/title_menu.tscn")

# Restarts the scene
func _on_retry_button_pressed():
	get_tree().reload_current_scene()
	globalVariables.health = 10
	get_tree().paused = false

# Returns to main menu.
func _on_death_exit_button_pressed():
	get_tree().change_scene_to_file("res://scenes/ui_scenes/title_menu.tscn")
	deathScreen.hide()

# Cues interaction.
func _on_yes_leave_button_pressed():
	if globalVariables.currentInteraction == "villageExit":
		get_tree().change_scene_to_file("res://scenes/site_scenes/overworld.tscn")
	if globalVariables.currentInteraction == "enemy1Exit":
		get_tree().change_scene_to_file("res://scenes/site_scenes/overworld.tscn")
	if globalVariables.currentInteraction == "villageEntrance":
		get_tree().change_scene_to_file("res://scenes/site_scenes/village.tscn")
	if globalVariables.currentInteraction == "enemy1Entrance":
		get_tree().change_scene_to_file("res://scenes/site_scenes/enemy_encounter_1.tscn")
	if globalVariables.currentInteraction == "tutorialExit":
		get_tree().change_scene_to_file("res://scenes/site_scenes/village.tscn")

# Closes leave menu.
func _on_no_leave_button_pressed():
	leaveMenu.hide()
	get_tree().paused = false
	interacting = false


# Closes dialogue box.
func _on_dialogue_return_button_pressed():
	dialogueBox.hide()
	get_tree().paused = false
	interacting = false
