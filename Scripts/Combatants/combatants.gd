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


# func _on_base_state_unhandled_input(event):

# 	if event.is_action_pressed("LMB"):
# 		var combatant = combat_service.get_combatant_on_current_mouse_position()
# 		if combatant:
# 			selected_combatant = combatant
# 			navigation_service.show_combatant_movement_range(combatant)
# 			BattleEventBus.emit_signal("CombatantClicked")
# 			if combatant in player_combatant_group.combatants:
# 				BattleEventBus.emit_signal("PlayerCombatantClicked")
# 		else:
# 			selected_combatant = null
			
		

# func _on_combatant_clicked_state_unhandled_input(event):
# 	if event.is_action_pressed("LMB"):

# 		if selected_combatant not in player_combatant_group.combatants:
# 			BattleEventBus.emit_signal("ActionCanceled")
# 			return

# 		# If clicked in hightlighted area, perform action
# 		if navigation_service.is_local_mouse_position_in_AOE():
# 			if selected_combatant.is_moving():
# 				return
			
# 			var path = navigation_service.get_local_point_path(selected_combatant.position, get_local_mouse_position())
# 			selected_combatant.move_along_path(path)
# 			selected_combatant.cell_coord  = navigation_service.get_cell_at_local_mouse_position()

# 		BattleEventBus.emit_signal("ActionCanceled")


### Signal responses ###
# func _on_attack_button_pressed():
	# var attack_pattern = selected_combatant.attack_pattern()
	# combat_service.highlight_attack_pattern(attack_pattern)

	# print('Attack pressed from combatants')









