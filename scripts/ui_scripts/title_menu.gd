extends Node2D

# We need to set our scene, set our music, and make Dale animated.
@onready var globalVariables = get_node("/root/DaleAutoload")
@onready var animation = $DaleSprite/AnimationPlayer
@onready var musicPlayer = get_node("/root/MusicPlayer")

# We need to assign our other menus to variables so we can make them appear.
@onready var controls = $Controls
@onready var musicVolume = $"VolumeControl"
@onready var titleMenu = $TitleMenu

# We need to be able to set our current volume on this scene so it doesn't constantly reset.
@onready var volumeSlider = $VolumeControl/MarginContainer/VBoxContainer/CenterContainer/VBoxContainer/VolumeSlider
var currentVolume = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	globalVariables.currentScene = "title"
	animation.play("title_screen")

# This will set our volume slider to the current volume when the scene loads.
	if musicPlayer.volume == -80:
		currentVolume = 0
	else:
		currentVolume = (musicPlayer.volume / 20) + 1
	volumeSlider.value = currentVolume

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/site_scenes/village.tscn")

func _on_controls_button_pressed():
	controls.show()
	titleMenu.hide()

func _on_controls_return_button_pressed():
	controls.hide()
	titleMenu.show()

# This controls our volume relative to the volume slider. 
func _on_volume_slider_value_changed(value):
	if value == 0:
		musicPlayer.volume = -80.0
	else:
		musicPlayer.volume = -20 + (value * 20)


func _on_volume_button_pressed():
	musicVolume.show()
	titleMenu.hide()


func _on_volume_return_pressed():
	musicVolume.hide()
	titleMenu.show()
