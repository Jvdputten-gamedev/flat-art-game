extends Node2D
class_name Combatant
enum Allegiance {FRIENDLY, NEUTRAL, ENEMY}

@export var allegiance: Allegiance
@export var unit_name: String
@export var movement_range: int
@export var movement_preview: MovePreviewComponent


func _to_string():
    return "{name} ({allegiance})".format({"name": unit_name, "allegiance": Allegiance.keys()[allegiance]})


func move(to_hex: HexCell):
    var current_hex = ServiceLocator.tile_service.local_to_hex(position)
    position = to_hex.to_point()
    BattleEventBus.CombatantMoved.emit(current_hex, to_hex)

func enable_movement_preview():
    movement_preview.enable()

func disable_movement_preview():
    movement_preview.disable()







