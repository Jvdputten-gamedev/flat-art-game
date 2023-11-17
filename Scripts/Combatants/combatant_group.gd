extends Node2D
class_name CombatantGroup

var num_combatants: int
var navigation_service: Node
var combat_service: Node

func initialize():
	navigation_service = ServiceLocator.get_navigation_service()
	combat_service = ServiceLocator.get_combat_service()

func get_num_combatants() -> int:
	return get_child_count()
