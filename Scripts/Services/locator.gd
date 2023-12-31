extends Node

const SERVICES_SCENE: PackedScene = preload("res://scenes/Components/Services.tscn")
var services_node
var services = {}

var tile_service: TileService:
	get:
		return get_tile_service()

var navigation_service: NavigationService:
	get:
		return get_navigation_service()

var combat_service: CombatService:
	get:
		return get_combat_service()

enum Services {TILE_SERVICE = 0, NAVIGATION_SERVICE = 1, COMBAT_SERVICE = 2}

func _ready():
	print("1. Service locator ready.")
	services_node = SERVICES_SCENE.instantiate()
	add_child(services_node)
	register_tile_service(services_node.tile_service)
	register_navigation_service(services_node.navigation_service)
	register_combat_service(services_node.combat_service)

func initialize_services():
	services_node.initialize()

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
