extends CanvasLayer

@export var turn_label: Label
@export var buttons_container: HBoxContainer

func _ready():
	BattleEventBus.connect("EnemyTurnStart", _on_enemy_turn_start)
	BattleEventBus.connect("EnemyTurnEnd", _on_enemy_turn_end)

func _on_move_pressed():
	UIEventBus.emit_signal("MovePressed")

func _on_end_turn_pressed():
	UIEventBus.emit_signal("EndTurnPressed")

func _on_enemy_turn_start():
	_disable_ui()
	var tween = create_tween()
	tween.tween_method(_set_label_countdown_text, 4, 1, 3)
	tween.connect("finished", _on_enemy_turn_end)

func _set_label_countdown_text(val: int):
	turn_label.text = "Doing enemy turn stuff: " + str(val)

func _disable_ui():
	buttons_container.visible = false

func _enable_ui():
	buttons_container.visible = true

func _on_enemy_turn_end():
	_enable_ui()
	turn_label.text = "Player turn" 
