extends Node2D
class_name CombatantGroup

var num_combatants: int
var combatants: Array[Combatant] = []
var navigation_service: Node
var combat_service: Node


func initialize():
	navigation_service = ServiceLocator.get_navigation_service()
	combat_service = ServiceLocator.get_combat_service()
	_initialize_combatants()


func _initialize_combatants():
	print("    Add nodes to combatant list")
	for unit in get_children():
		num_combatants += 1
		unit.position = navigation_service.get_random_available_position()
		combatants.append(unit as Combatant)

	print("    Update cell dictionary")


func start_turn():
	pass

