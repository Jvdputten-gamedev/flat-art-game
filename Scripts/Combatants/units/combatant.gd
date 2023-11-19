extends Node2D
class_name Combatant
enum Allegiance {FRIENDLY, NEUTRAL, ENEMY}

var allegiance: Allegiance
var unit_name: String
var cell_coord: Vector2i:
    set(to_cell):
        var from_cell = cell_coord
        cell_coord = to_cell
        BattleEventBus.emit_signal("CombatantMoved", self, from_cell, to_cell)

func _to_string():
    return "{name} ({allegiance})".format({"name": unit_name, "allegiance": Allegiance.keys()[allegiance]})


