extends CombatantGroup


func initialize() -> void:
	super.initialize()
	BattleEventBus.emit_signal("EnemyTurnStart")
	BattleEventBus.emit_signal("EnemyTurnEnd")

func start_turn() -> void:
	print("Start Enemy turn")
	BattleEventBus.emit_signal("EnemyTurnStart")
	



	

