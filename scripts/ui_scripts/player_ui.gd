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
	if globalVariables.healthBuffed == false:
		healthBar.frame = 23 - globalVariables.health
	elif globalVariables.healthBuffed == true:
		healthBar.frame = 12 - globalVariables.health
	
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
			if globalVariables.currentInteraction == "villageExit" || globalVariables.currentInteraction == "enemy1Exit" || globalVariables.currentInteraction == "villageEntrance" || globalVariables.currentInteraction == "enemy1Entrance" || globalVariables.currentInteraction == "tutorialExit" || globalVariables.currentInteraction == "tutorialEntrance" || globalVariables.currentInteraction == "witchExit" || globalVariables.currentInteraction == "witchEntrance" || globalVariables.currentInteraction == "arenaExit" || globalVariables.currentInteraction == "arenaEntrance" || globalVariables.currentInteraction == "mountainExit" || globalVariables.currentInteraction == "mountainEntrance":
				leaveMenu.show()
				get_tree().paused = true
				interacting = true
	elif interacting == true:
		if Input.is_action_just_pressed("interact") && leaveMenu.is_visible_in_tree() == true:
			if globalVariables.currentInteraction == "villageExit" || globalVariables.currentInteraction == "enemy1Exit" || globalVariables.currentInteraction == "villageEntrance" || globalVariables.currentInteraction == "enemy1Entrance"|| globalVariables.currentInteraction == "tutorialExit" || globalVariables.currentInteraction == "tutorialEntrance"|| globalVariables.currentInteraction == "witchExit" || globalVariables.currentInteraction == "witchEntrance" || globalVariables.currentInteraction == "arenaExit" || globalVariables.currentInteraction == "arenaEntrance" || globalVariables.currentInteraction == "mountainExit" || globalVariables.currentInteraction == "mountainEntrance":
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
		leaveText.text = "Search for the Beet?"
	if globalVariables.currentInteraction == "tutorialExit":
		leaveText.text = "Head to the village?"
	if globalVariables.currentInteraction == "tutorialEntrance":
		leaveText.text = "Return to the beginning?"
	if globalVariables.currentInteraction == "witchExit":
		leaveText.text = "Return to the Great Valley?"
	if globalVariables.currentInteraction == "witchEntrance":
		leaveText.text = "Visit the Witch?"
	if globalVariables.currentInteraction == "arenaExit":
		leaveText.text = "Leave the Arena?"
	if globalVariables.currentInteraction == "arenaEntrance":
		leaveText.text = "Enter the Arena?"
	if globalVariables.currentInteraction == "mountainExit":
		leaveText.text = "Leave the Mountain?"
	if globalVariables.currentInteraction == "mountainEntrance":
		leaveText.text = "Scale the Mountain?"


	# This will control our dialogue text.
	if interacting == false:
		if Input.is_action_just_pressed("interact") && dialogueBox.is_visible_in_tree() == false:
			if globalVariables.currentInteraction == "tSign1" || globalVariables.currentInteraction == "tSign2" || globalVariables.currentInteraction == "tSign3" || globalVariables.currentInteraction == "tSign4" || globalVariables.currentInteraction == "tSign5"|| globalVariables.currentInteraction == "tSign6" || globalVariables.currentInteraction == "tSign7"|| globalVariables.currentInteraction == "tSign8" || globalVariables.currentInteraction == "vSign1" || globalVariables.currentInteraction == "vSign2" || globalVariables.currentInteraction == "village_elder" || globalVariables.currentInteraction == "villager1" || globalVariables.currentInteraction == "villager2" || globalVariables.currentInteraction == "witch" || globalVariables.currentInteraction == "strongman":
				dialogueBox.show()
				get_tree().paused = true
				interacting = true
				if globalVariables.healthBuffed == false && globalVariables.currentInteraction == "witch" && globalVariables.hasBeet == true:
					globalVariables.maxHealth = 12
					globalVariables.health = 12
					globalVariables.healthBuffed = true
					globalVariables.treasuresFound += 1
	elif interacting == true:
		if Input.is_action_just_pressed("interact") && dialogueBox.is_visible_in_tree() == true:
			if globalVariables.currentInteraction == "tSign1" || globalVariables.currentInteraction == "tSign2" || globalVariables.currentInteraction == "tSign3" || globalVariables.currentInteraction == "tSign4" || globalVariables.currentInteraction == "tSign5"|| globalVariables.currentInteraction == "tSign6" || globalVariables.currentInteraction == "tSign7"|| globalVariables.currentInteraction == "tSign8" || globalVariables.currentInteraction == "vSign1" || globalVariables.currentInteraction == "vSign2" || globalVariables.currentInteraction == "village_elder" || globalVariables.currentInteraction == "villager1" || globalVariables.currentInteraction == "villager2" || globalVariables.currentInteraction == "witch" || globalVariables.currentInteraction == "strongman":
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

You may sometimes find floating hearts in your travels.
These can replenish your health if you eat them. Tasty!

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

	if globalVariables.currentInteraction == "vSign1":
		dialogueText.text = "



Village of First Light



" 

	if globalVariables.currentInteraction == "vSign2":
		dialogueText.text = "



The Great Valley lies beyond this point.



" 

	if globalVariables.currentInteraction == "village_elder":
		dialogueText.text = "Hello, Great One. You are always welcome in our village.
We must request of you a boon. We seek three sacred
relics to help us fend off the monsters from the hills.
Return to me once you have:
- The Sacred Scales of Strength from the Great Arena
- The Tears of the Old Ones from the Eastern Bald 
Mountain
- A Brew of Fortitude from the Witch in the North"

	if globalVariables.currentInteraction == "villager1":
		dialogueText.text = "
Hello, Great One. It is so rare for one of your kind to 
scale themselves down to walk among us. You should
test your strength in the Great Arena far south of the
town. It is several days of travel for us, but you can
probably make the trip in a few seconds.


"

	if globalVariables.currentInteraction == "villager2":
		dialogueText.text = "
Dale? Is that you? I can't see as well as I could in my 
youth. Well it is good to somewhat see you, Scaly One.
Say, did I ever tell you about when I was apprenticed
to the Witch of the North? She lives in a secluded hut
north of First Light. I still remember the scent of herbs
and the light of dawn cresting through the mountains.

"

	if globalVariables.currentInteraction == "witch":
		if globalVariables.hasBeet == false:
			dialogueText.text = "
Hello dearie, let me have a look at you. Oh my, you are 
older than even me. A Brew of Fortitude you say? Well
I can brew one if you bring me a Divine Beet from the 
Garden of Beets to the east of this place. May the 
Great Spirits watch over you, Old One.


"
		elif globalVariables.hasBeet == true:
			dialogueText.text = "
Ah yes, this is exactly what we need. Just a pinch of 
peppermint and a hint of cactus juice. Then we add 
some lost dreams, and a whiff of distant longing. Here 
you go dearie, try it out. Good, isn't it? Take it back
to the village and give them my blessing. Go in peace,
Old One.

"

	if globalVariables.currentInteraction == "strongman":
		if globalVariables.hasScales == false:
			dialogueText.text = "
Ohohohoho another challenger for the Arena. Good luck 
to you sir. I have been training for 67 years and will
someday test my own luck, but only once I am ready 
for I have watched too many good adventurers die in
the Arena's harsh embrace. 


"
		if globalVariables.hasScales == true:
			dialogueText.text = "

What? You did it? You have the scales? How is this 
possible? Traveller, I beg of you - please tell me your 
secret. I shall continue training forevermore. Ohohoho.



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
	if globalVariables.currentInteraction == "tutorialEntrance":
		get_tree().change_scene_to_file("res://scenes/site_scenes/tutorial_area.tscn")
	if globalVariables.currentInteraction == "witchExit":
		get_tree().change_scene_to_file("res://scenes/site_scenes/overworld.tscn")
	if globalVariables.currentInteraction == "witchEntrance":
		get_tree().change_scene_to_file("res://scenes/site_scenes/witch_house.tscn")
	if globalVariables.currentInteraction == "arenaExit":
		get_tree().change_scene_to_file("res://scenes/site_scenes/overworld.tscn")
	if globalVariables.currentInteraction == "arenaEntrance":
		get_tree().change_scene_to_file("res://scenes/site_scenes/arena.tscn")
	if globalVariables.currentInteraction == "mountainExit":
		get_tree().change_scene_to_file("res://scenes/site_scenes/overworld.tscn")
	if globalVariables.currentInteraction == "mountainEntrance":
		get_tree().change_scene_to_file("res://scenes/site_scenes/mountain.tscn")

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
