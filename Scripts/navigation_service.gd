extends Node

@export var tilemap: TileMap

var astar: AStar2DHex

func _ready():
    astar = AStar2DHex.new()

