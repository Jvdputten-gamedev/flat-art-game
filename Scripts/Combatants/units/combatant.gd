extends Node2D
class_name Combatant

@export var unit_name: String
@export var movement_range: int


func _to_string():
    return "{name} ({allegiance})".format({"name": unit_name, "allegiance": Allegiance.keys()[allegiance]})

func get_current_hex():
    return ServiceLocator.tile_service.local_to_hex(position)

func get_current_tile():
    return ServiceLocator.tile_service.local_to_tile(position)

func move(to_tile: BasicTile):
    var current_tile = get_current_tile()
    current_tile.vacate()
    to_tile.occupy(self)
    position = to_tile.to_point()









