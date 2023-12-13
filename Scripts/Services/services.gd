extends Node

@export var navigation_service: Node2D
@export var combat_service: Node2D
@export var tile_service: Node2D

func initialize() -> void:
	print("3. Initializing services")
	navigation_service.initialize()
	combat_service.initialize()
