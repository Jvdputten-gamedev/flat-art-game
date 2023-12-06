extends Node2D
class_name LevelBase

@export var services: Node
@export var environment: Node2D
@export var combatants: Node2D

var tile_service: TileService
var navigation_service: NavigationService


func _ready():
	#services.register()
	environment.initialize()
	services.initialize()
	combatants.initialize()
	tile_service = ServiceLocator.get_tile_service()
	navigation_service = ServiceLocator.get_navigation_service()



