class_name Game
extends Node2D
## The main scene of the game.l


## The player node.
@onready var player: Player = $Player
## The tilemap node.
@onready var tilemap: TileMap = $TileMap


## Creates the level.
func _ready() -> void:
	
	var circle: Circle = preload("res://nodes/circle.tscn").instantiate()
	
	var data: Dictionary = GameUtils.open_level("level")
	for i in data.map.size():
		
		var row: Array = data.map[i]
		
		for j in row.size():
			self.tilemap.set_cell(0, Vector2i(j, i), 0, Vector2i(row[j], 0))
	self.player.position = GameUtils.array_to_vector2(data.player) * 32 + Vector2.ONE * 16
	circle.position = Vector2(32 * 5, 32 * 8) + Vector2(16, 16)
	self.add_child(circle)
