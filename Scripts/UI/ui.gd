extends CanvasLayer

@export var turn_label: Label
@export var buttons_container: HBoxContainer

func _ready():
	BattleEventBus.connect("EnemyTurnStart", _on_enemy_turn_start)
	BattleEventBus.connect("EnemyTurnEnd", _on_enemy_turn_end)
	BattleEventBus.connect("PlayerCombatantClicked", _on_player_combatant_clicked)
	BattleEventBus.connect("ActionCanceled", _on_action_canceled)

	_disable_buttons()




func _on_enemy_turn_start():
	_disable_buttons()
	var tween = create_tween()
	tween.tween_method(_set_label_countdown_text, 4, 1, 3)
	tween.connect("finished", _on_enemy_turn_end)

func _set_label_countdown_text(val: int):
	turn_label.text = "Doing enemy turn stuff: " + str(val)

func _disable_buttons():
	buttons_container.visible = false

func _enable_buttons():
	buttons_container.visible = true


### Internal signal responses

func _on_attack_pressed():
	UiEventBus.emit_signal("AttackButtonPressed")

func _on_end_turn_pressed():
	UiEventBus.emit_signal("EndTurnPressed")



### Signal responses

func _on_enemy_turn_end():
		turn_label.text = "Player turn" 

func _on_player_combatant_clicked():
	_enable_buttons()

func _on_action_canceled():
	_disable_buttons()




