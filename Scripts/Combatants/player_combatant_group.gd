extends Node2D


@export var navigation_service: Node
@export var player: Node2D

func setup() -> void:
    player.position = navigation_service.tilemap.map_to_local(Vector2i(0,0))

