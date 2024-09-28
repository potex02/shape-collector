class_name LevelManager
extends Control
## The class that manages the level selection.


## The game scene:
const GAME: PackedScene = preload("res://scenes/game.tscn")
## The ui container.
@onready var grid_container: GridContainer = $GridContainer


## Creates the ui.
func _ready() -> void:
	for i in range(10):
		
		var button: Button = Button.new()
		
		button.text = str(i + 1)
		button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		button.size_flags_vertical = Control.SIZE_EXPAND_FILL
		button.pressed.connect(self._laod_level.bind(i + 1))
		self.grid_container.add_child(button)


## Loads a level.
func _laod_level(level: int) -> void:
	
	var game: Game = LevelManager.GAME.instantiate()
	
	game.current_level = level
	self.get_tree().root.add_child(game)
	self.queue_free()
