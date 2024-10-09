class_name Game
extends Node2D
## The main scene of the game.l


## The circle node.
const CIRCLE: PackedScene = preload("res://nodes/circle.tscn")
## The square node.
const SQUARE: PackedScene = preload("res://nodes/square.tscn")
## The diamond node.
const DIAMOND: PackedScene = preload("res://nodes/diamond.tscn")
## The player node.
@onready var _player: Player = $Player
## The tilemap node.
@onready var _tilemap_layer: TileMapLayer = $TileMapLayer
## The score label.
@onready var _score: Label = $CanvasLayer/Score
## The current level.
var current_level: int


## Creates the level.
func _ready() -> void:
	
	var data: Dictionary = GameUtils.open_level(self.current_level)
	
	self._player.score_changed.connect(self._on_score_changed)
	self._player.game_over.connect(self._on_game_over)
	self._tilemap_layer.modulate = data.modulate.map
	for i in data.map.size():
		
		var row: Array = data.map[i]
		
		for j in row.size():
			
			var coords: Vector2i = Vector2i(j, i)
			var tile: int = row[j]
			
			if tile == 1:
				
				var circle: Circle = Game.CIRCLE.instantiate()
			
				circle.position = GameUtils.coords_to_pos(coords)
				circle.modulate = data.modulate.circles
				self.add_child(circle)
			if tile == 2:
				self._player.position = GameUtils.coords_to_pos(coords)
				self._player.normal_modulate = data.modulate.player.normal
				self._player.power_up_modulate = data.modulate.player.power_up
				self._player.modulate = self._player.normal_modulate
			if tile == 3:
				
				var square: Square = Game.SQUARE.instantiate()
				
				square.position = GameUtils.coords_to_pos(coords)
				square.modulate = data.modulate.squares
				self.add_child(square)
				square.removed.connect(func() -> void:
					self.remove_child(square)
					self.get_tree().create_timer(5).timeout.connect(func() -> void:
						square.first = true
						square.position = GameUtils.coords_to_pos(coords)
						self.add_child(square)
					)
				)
				self._tilemap_layer.set_cell(coords, 0, Vector2i(row[j], 0))
			if tile == 4:
				
				var diamond: Diamond = Game.DIAMOND.instantiate()
				
				diamond.position = GameUtils.coords_to_pos(coords)
				diamond.modulate = data.modulate.diamonds
				self.add_child(diamond)
				self._tilemap_layer.set_cell(coords, 0, Vector2i(row[j], 0))
			self._tilemap_layer.set_cell(coords, 0, Vector2i(0 if tile == 0 else 1, 0))


## Updates the score label.
func _on_score_changed() -> void:
	self._score.text = str(self._player.score)


## Handles a game over.
func _on_game_over() -> void:
	self._score.text = "Game Over"
