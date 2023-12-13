extends Node2D

@export var player_combatant_group: Node2D
@export var enemy_combatant_group: Node2D

var navigation_service: Node


func _ready():
	# UiEventBus.connect("AttackButtonPressed", _on_attack_button_pressed)
	navigation_service = ServiceLocator.get_navigation_service()
	initialize()

func initialize():
	print("4. Initialize combatants")
	player_combatant_group.initialize()
	enemy_combatant_group.initialize()


### Signal responses ###
# func _on_attack_button_pressed():
	# var attack_pattern = selected_combatant.attack_pattern()
	# combat_service.highlight_attack_pattern(attack_pattern)

	# print('Attack pressed from combatants')









