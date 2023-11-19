extends Node

var services = {}

enum Services {NAVIGATION_SERVICE = 0, COMBAT_SERVICE = 1}

func _ready():
	print("1. Service locator ready")


func _register_service(service_id: Services, service: Service) -> void:
	services[service_id] = service

func _get_service(service_id: Services) -> Service:
	if service_id in services.keys():
		return services[service_id]
	else:
		print("Warning, service not set")
		return null

func register_navigation_service(service: Service) -> void:
	print("  1.1 Register navigation service")
	_register_service(Services.NAVIGATION_SERVICE, service)

func register_combat_service(service: Service) -> void:
	print("  1.2 Register combat service")
	_register_service(Services.COMBAT_SERVICE, service)

func get_navigation_service() -> Service:
	return _get_service(Services.NAVIGATION_SERVICE)

func get_combat_service() -> Service:
	return _get_service(Services.COMBAT_SERVICE)