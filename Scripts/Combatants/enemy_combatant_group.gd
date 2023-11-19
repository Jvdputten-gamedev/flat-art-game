extends CombatantGroup


func initialize() -> void:
	print("  4.2 Initializing enemy combatant group")
	super.initialize()

func start_turn() -> void:
	print("Start Enemy turn")
	BattleEventBus.emit_signal("EnemyTurnStart")
	await get_tree().create_timer(3).timeout
	BattleEventBus.emit_signal("EnemyTurnEnd")

	



	

