class_name GameUtils
extends RefCounted
## A class for utility functions.
##
## All methods of this class are static



## Opens a [param name].json file and returns the content.
static func open_level(level: StringName) -> Variant:
	
	var path: StringName = &"res://levels/%s.json" % level
	var file: FileAccess
	var json: JSON = JSON.new()
	
	if not FileAccess.file_exists(path):
		return {}
	file = FileAccess.open(path, FileAccess.READ)
	json.parse(file.get_as_text())
	file.close()
	return json.get_data()


## Converts the [param array] to a [Vector2].
static func array_to_vector2(array: Array) -> Vector2:
	if array.size() != 2:
		return Vector2.ZERO
	return Vector2(array[0], array[1])


## Converts the coordinate to the position.
static func coords_to_pos(coords: Vector2i) -> Vector2i:
	return coords * 32 + Vector2i.ONE * 16
