extends Node

@export var navigation_service: Node
@export var combat_service: Node

func register():
	ServiceLocator.register_navigation_service(navigation_service as Service)

func initialize() -> void:
	print('in services')
	navigation_service.initialize_astar()
