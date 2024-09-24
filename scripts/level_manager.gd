class_name LevelManager
extends Control
## The class that manages the level selection.


## The ui container.
@onready var grid_container: GridContainer = $GridContainer


## Creates the ui.
func _ready():
	for i in range(10):
		
		var button: Button = Button.new()
		
		button.text = str(i + 1)
		button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		button.size_flags_vertical = Control.SIZE_EXPAND_FILL
		button.pressed.connect(self.get_tree().change_scene_to_file.bind("res://scenes/game.tscn"))
		self.grid_container.add_child(button)
