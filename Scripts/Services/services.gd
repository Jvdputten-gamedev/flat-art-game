extends Node

@export var navigation_service: Node2D
@export var combat_service: Node2D
@export var tile_service: Node2D

func register():
	ServiceLocator.register_tile_service(tile_service as TileService)
	ServiceLocator.register_navigation_service(navigation_service as Service)
	ServiceLocator.register_combat_service(combat_service as Service)

func initialize() -> void:
	print("3. Initializing services")
	navigation_service.initialize()
	combat_service.initialize()
