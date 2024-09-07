class_name Game
extends Node2D
## The main scene of the game.l



## The circle node.
const CIRCLE: PackedScene = preload("res://nodes/circle.tscn")
## The diamond node.
const DIAMOND: PackedScene = preload("res://nodes/diamond.tscn")
## The player node.
@onready var player: Player = $Player
## The tilemap node.
@onready var tilemap: TileMap = $TileMap
## The score label.
@onready var score: Label = $CanvasLayer/Score


## Creates the level.
func _ready() -> void:
	
	var data: Dictionary = GameUtils.open_level("level")
	var player_position: Vector2i = GameUtils.array_to_vector2(data.player)
	
	self.player.score_changed.connect(self._on_score_changed)
	self.player.game_over.connect(self._on_game_over)
	for i in data.map.size():
		
		var row: Array = data.map[i]
		
		for j in row.size():
			
			var coords: Vector2i = Vector2i(j, i)
			
			if coords == Vector2i(5, 5):
				
				var diamond: Diamond = Game.DIAMOND.instantiate()
				
				diamond.position = GameUtils.coords_to_pos(coords)
				self.add_child(diamond)
				self.tilemap.set_cell(0, coords, 0, Vector2i(row[j], 0))
				continue
			if row[j] == 1 and coords != player_position:
				
				var circle: Circle = Game.CIRCLE.instantiate()
				
				circle.position = GameUtils.coords_to_pos(coords)
				self.add_child(circle)
			self.tilemap.set_cell(0, coords, 0, Vector2i(row[j], 0))
	self.player.position = GameUtils.coords_to_pos(player_position)
	$Square.position = GameUtils.coords_to_pos(Vector2i(10, 10))


## Updates the score label.
func _on_score_changed() -> void:
	self.score.text = str(self.player.score)


## Handles a game over.
func _on_game_over() -> void:
	self.score.text = "Game Over"
