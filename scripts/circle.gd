class_name Circle
extends Area2D
## The class representing the circles to collect in the game.


## Conencts the [signal Area2D.area_entered].
func _ready() -> void:
	self.area_entered.connect(self._on_area_entered)


## handles the player collision.
func _on_area_entered(area: Area2D) -> void:
	if area is Player:
		area.collect()
		self.queue_free()
