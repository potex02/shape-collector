class_name Menu
extends Control
## The menu scene of the game.


## Connects the signal of the strrt button. 
func _ready():
	$Button.pressed.connect(self.get_tree().change_scene_to_file.bind("res://scenes/level_manager.tscn"))
