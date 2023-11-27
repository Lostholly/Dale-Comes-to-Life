extends TileMap

@onready var globalVariables = get_node("/root/DaleAutoload")

# Called when the node enters the scene tree for the first time.
func _ready():
	globalVariables.currentScene = "village"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
