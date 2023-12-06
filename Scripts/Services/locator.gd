extends Node

const SERVICES_SCENE: PackedScene = preload("res://scenes/Components/Services.tscn")
var services = {}

enum Services {TILE_SERVICE = 0, NAVIGATION_SERVICE = 1, COMBAT_SERVICE = 2}

func _ready():
	print("1. Service locator ready")
	var services_scene = SERVICES_SCENE.instantiate()
	add_child(services_scene)
	register_tile_service(services_scene.tile_service)
	register_navigation_service(services_scene.navigation_service)
	register_combat_service(services_scene.combat_service)

func _register_service(service_id: Services, service: Service) -> void:
	services[service_id] = service

func _get_service(service_id: Services) -> Service:
	if service_id in services.keys():
		return services[service_id]
	else:
		print("Warning, service with id {0} not set".format([service_id]))
		return null

func register_tile_service(service: Service) -> void:
	print("  1.1 Register tile service")
	_register_service(Services.TILE_SERVICE, service)

func register_navigation_service(service: Service) -> void:
	print("  1.2 Register navigation service")
	_register_service(Services.NAVIGATION_SERVICE, service)

func register_combat_service(service: Service) -> void:
	print("  1.3 Register combat service")
	_register_service(Services.COMBAT_SERVICE, service)

func get_navigation_service() -> Service:
	return _get_service(Services.NAVIGATION_SERVICE)

func get_combat_service() -> Service:
	return _get_service(Services.COMBAT_SERVICE)

func get_tile_service() -> TileService:
	return _get_service(Services.TILE_SERVICE) as TileService
