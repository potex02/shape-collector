class_name Game
extends Node2D
## The main scene of the game.l


func _ready() -> void:
	
	var circle: Circle = preload("res://nodes/circle.tscn").instantiate()
	
	print(GameUtils.open_level("level"))
	circle.position = Vector2(32 * 5, 32 * 8) + Vector2(16, 16)
	self.add_child(circle)
