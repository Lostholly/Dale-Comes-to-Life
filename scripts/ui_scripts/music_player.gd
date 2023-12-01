extends Node

# We need to get our scene to know what to play.
@onready var globalVariables = get_node("/root/DaleAutoload")

# We need each song assigned to a variable
@onready var fightMusic = $FightMusic
@onready var bossMusic = $BossMusic
@onready var overworldMusic = $OverworldMusic
@onready var titleMusic = $TitleMusic
@onready var townMusic = $TownMusic
@onready var witchMusic = $WitchMusic

# We need a volume variable.
var volume = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(_delta):
	# This is where we will check what scene we are in and play the corresponding music.
	if globalVariables.currentScene == "title" && titleMusic.playing == false:
		titleMusic.play()
	elif globalVariables.currentScene != "title":
		titleMusic.stop()

	if globalVariables.currentScene == "village" && townMusic.playing == false:
		townMusic.play()
	elif globalVariables.currentScene != "village":
		townMusic.stop()

	if globalVariables.currentScene == "overworld" || globalVariables.currentScene == "tutorial": 
		if overworldMusic.playing == false:
			overworldMusic.play()
	elif globalVariables.currentScene != "overworld" && globalVariables.currentScene != "tutorial":
		overworldMusic.stop()

	if globalVariables.currentScene == "enemyEncounter1" && fightMusic.playing == false:
		fightMusic.play()
	elif globalVariables.currentScene != "enemyEncounter1":
		fightMusic.stop()
	
	if globalVariables.currentScene == "witchHouse" && witchMusic.playing == false:
		witchMusic.play()
	elif globalVariables.currentScene != "witchHouse":
		witchMusic.stop()

	if globalVariables.currentScene == "arena" || globalVariables.currentScene == "mountain":
		if bossMusic.playing == false:
			bossMusic.play()
	elif globalVariables.currentScene != "arena" && globalVariables.currentScene != "mountain":
		bossMusic.stop()

	# We have to control our volume for the volume slider.
	fightMusic.volume_db = volume
	bossMusic.volume_db = volume
	overworldMusic.volume_db = volume
	titleMusic.volume_db = volume
	townMusic.volume_db = volume
	witchMusic.volume_db = volume
