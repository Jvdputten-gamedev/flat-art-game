extends Node2D

@export var player_combatant_group: Node2D
@export var enemy_combatant_group: Node2D
@export var _state_chart: StateChart

var is_player_turn: bool

func _ready():
	UIEventBus.connect("EndTurnPressed", _on_end_turn_pressed)
	BattleEventBus.connect("EnemyTurnEnd", _on_enemy_turn_end)
	is_player_turn = true
	player_combatant_group.start_turn()

func initialize():
	player_combatant_group.initialize()
	enemy_combatant_group.initialize()

func get_next_combatant_group() -> CombatantGroup:
	if is_player_turn:
		is_player_turn = false
		return enemy_combatant_group
	else:
		is_player_turn = true
		return player_combatant_group

func _next_combatant_group():
	var next_group = get_next_combatant_group()
	next_group.start_turn()

func _on_end_turn_pressed():
	_next_combatant_group()
	_state_chart.send_event("end_player_turn")


func _on_enemy_turn_end():
	_next_combatant_group()
	_state_chart.send_event("end_enemy_turn")

func _on_player_turn_state_stepped():
	print("called from state transition to ")


func _on_enemy_turn_state_stepped():
	pass # Replace with function body.
