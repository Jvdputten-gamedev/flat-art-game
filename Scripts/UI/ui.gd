extends CanvasLayer


func _on_move_pressed():
	UIEventBus.emit_signal("MovePressed")
