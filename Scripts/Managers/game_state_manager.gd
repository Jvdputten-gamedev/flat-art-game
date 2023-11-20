extends Node

@export var _state_chart: StateChart


func _ready():
	BattleEventBus.connect("CombatantClicked", _on_combatant_clicked)
	BattleEventBus.connect("ActionCanceled", _on_action_canceled)


### Signal response ###

func _on_combatant_clicked():
	_state_chart.send_event("combatant_clicked")

func _on_action_canceled():
	_state_chart.send_event("action_canceled")



