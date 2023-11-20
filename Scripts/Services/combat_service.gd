extends Service
var _cell_occupant: Dictionary
var navigation_service

func _ready():
	BattleEventBus.connect("CombatantMoved",_on_combatant_moved)

func initialize():
	print("  3.2 Initialize combat service")
	navigation_service = ServiceLocator.get_navigation_service()
	initialize_cell_data()


func initialize_cell_data():
	print("  2.2 Initialize cell data dictionary")
	_cell_occupant = {}
	var cells = navigation_service.tilemap.get_ground_cells()
	for cell_coord in cells:
		_cell_occupant[cell_coord] = null


func get_cell_occupant(cell_coord: Vector2i):
	if cell_coord in _cell_occupant.keys():
		return _cell_occupant[cell_coord]
	else:
		return null

func cell_has_occupant(cell_coord: Vector2i):
	var occupant = get_cell_occupant(cell_coord)
	if occupant:
		return true
	else:
		return false

func get_combatant_on_current_mouse_position():
	return get_cell_occupant(navigation_service.get_cell_at_local_mouse_position())
	

func set_cell_occupant(cell_coord: Vector2i, value: Object):
	_cell_occupant[cell_coord] = value




### Signal responses ###
func _on_combatant_moved(combatant, from_cell, to_cell):
	#assert(combatant == _cell_occupant[from_cell], "Something went wrong, signaled combatant was not at the initial from_cell")

	_cell_occupant[from_cell] = null
	_cell_occupant[to_cell] = combatant

	print(combatant.to_string() + " moved from " + str(from_cell) + " to " + str(to_cell))
