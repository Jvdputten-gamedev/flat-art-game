extends CanvasLayer

@export var turn_label: Label

func _ready():
	pass

func _on_move_pressed():
	UIEventBus.emit_signal("MovePressed")

func _on_end_turn_pressed():
	var tween = create_tween()
	tween.tween_method(_set_label_countdown_text, 4, 1, 3)
	UIEventBus.emit_signal("EndTurnPressed")
	tween.connect("finished", _on_enemy_turn_end)

func _set_label_countdown_text(val: int):
	turn_label.text = "Doing enemy turn stuff: " + str(val)

func _on_enemy_turn_end():
	turn_label.text = "Player turn" 
