extends Node

func register():
	ServiceLocator.register_navigation_service($NavigationService as Service)

func initialize() -> void:
	print('in services')
	$NavigationService.initialize_astar()
