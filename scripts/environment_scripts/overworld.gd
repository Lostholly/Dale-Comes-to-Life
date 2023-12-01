extends TileMap

@onready var globalVariables = get_node("/root/DaleAutoload")

# Need to assign our interaction buttons to variables.
@onready var villageInteract = $VillageArea2D/CollisionShape2D/Sprite2D
@onready var villageAnimate = $VillageArea2D/CollisionShape2D/AnimationPlayer
@onready var enemy1Interact = $Enemy1Area2D/CollisionShape2D/Sprite2D
@onready var enemy1Animate = $Enemy1Area2D/CollisionShape2D/AnimationPlayer
@onready var witchHouseInteract = $WitchHouseArea2D/CollisionShape2D/Sprite2D
@onready var witchHouseAnimate = $WitchHouseArea2D/CollisionShape2D/AnimationPlayer
@onready var arenaInteract = $ArenaArea2D/CollisionShape2D/Sprite2D
@onready var arenaAnimate = $ArenaArea2D/CollisionShape2D/AnimationPlayer
@onready var mountainInteract = $MountainArea2D/CollisionShape2D/Sprite2D
@onready var mountainAnimate = $MountainArea2D/CollisionShape2D/AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	globalVariables.currentScene = "overworld"
	get_tree().paused = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


# This section deals with routing players to the correct location.
func _on_village_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		villageInteract.show()
		villageAnimate.play("interact")
		globalVariables.currentInteraction = "villageEntrance"
		globalVariables.sideviewStart = Vector2(6040, 357)


func _on_village_area_2d_body_exited(body):
	if body.is_in_group("Player"):
		villageInteract.hide()
		villageAnimate.stop()
		globalVariables.currentInteraction = ""


func _on_enemy_1_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		enemy1Interact.show()
		enemy1Animate.play("interact")
		globalVariables.currentInteraction = "enemy1Entrance"
		globalVariables.sideviewStart = Vector2(66, 613)


func _on_enemy_1_area_2d_body_exited(body):
	if body.is_in_group("Player"):
		enemy1Interact.hide()
		enemy1Animate.stop()
		globalVariables.currentInteraction = ""


func _on_witch_house_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		witchHouseInteract.show()
		witchHouseAnimate.play("interact")
		globalVariables.currentInteraction = "witchEntrance"
		globalVariables.sideviewStart = Vector2(100, 678)


func _on_witch_house_area_2d_body_exited(body):
	if body.is_in_group("Player"):
		witchHouseInteract.hide()
		witchHouseAnimate.stop()
		globalVariables.currentInteraction = ""


func _on_arena_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		arenaInteract.show()
		arenaAnimate.play("interact")
		globalVariables.currentInteraction = "arenaEntrance"
		globalVariables.sideviewStart = Vector2(246, 290)


func _on_arena_area_2d_body_exited(body):
	if body.is_in_group("Player"):
		arenaInteract.hide()
		arenaAnimate.stop()
		globalVariables.currentInteraction = ""


func _on_mountain_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		mountainInteract.show()
		mountainAnimate.play("interact")
		globalVariables.currentInteraction = "mountainEntrance"
		globalVariables.sideviewStart = Vector2(151, 527)


func _on_mountain_area_2d_body_exited(body):
	if body.is_in_group("Player"):
		mountainInteract.hide()
		mountainAnimate.stop()
		globalVariables.currentInteraction = ""
