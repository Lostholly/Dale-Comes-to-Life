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

# We need to be able to set our current volume on this scene so it doesn't constantly reset.
@onready var volumeSlider = $MenuControl/VolumeControl/MarginContainer/VBoxContainer/CenterContainer/VBoxContainer/VolumeSlider
var currentVolume = 1.0


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
	if Input.is_action_just_pressed("menu") && mainMenu.is_visible_in_tree() != true && controls.is_visible_in_tree() != true && volumeControl.is_visible_in_tree() != true:
		mainMenu.show()
		get_tree().paused = true
	elif Input.is_action_just_pressed("menu"):
		if mainMenu.is_visible_in_tree() == true || controls.is_visible_in_tree() == true || volumeControl.is_visible_in_tree() == true:
			mainMenu.hide()
			controls.hide()
			volumeControl.hide()
			get_tree().paused = false


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


func _on_retry_button_pressed():
	get_tree().reload_current_scene()
	globalVariables.health = 10
	get_tree().paused = false


func _on_death_exit_button_pressed():
	get_tree().change_scene_to_file("res://scenes/ui_scenes/title_menu.tscn")
	deathScreen.hide()
