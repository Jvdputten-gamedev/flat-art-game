extends CombatantGroup

func initialize() -> void:
	print("    Add nodes to combatant list")
	for combatant in get_children():
		num_combatants += 1
		print("  4.1 Initializing player combatant group")
		var hex = HexCell.new(Vector3(-1,0,1))
		var tile = ServiceLocator.tile_service.get_tile(hex.id)
		combatant.move(tile)


	



