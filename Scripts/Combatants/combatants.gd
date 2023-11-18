extends Node2D

@export var player_combatant_group: Node2D
@export var enemy_combatant_group: Node2D

var is_player_turn: bool


func _ready():
	UIEventBus.connect("EndTurnPressed", _on_end_turn)
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


func _on_end_turn():
	var next_group = get_next_combatant_group()
	next_group.start_turn()






