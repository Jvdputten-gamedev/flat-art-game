extends Node

@export var navigation_service: Node
@export var combat_service: Node

func register():
	ServiceLocator.register_navigation_service(navigation_service as Service)
	ServiceLocator.register_combat_service(combat_service as Service)

func initialize() -> void:
	print("3. Initializing services")
	navigation_service.initialize()
	combat_service.initialize()
