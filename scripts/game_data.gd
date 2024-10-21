class_name GameData
extends RefCounted
## The class used to store the save data.
##
## All members and methods of this class are static

## The last unlaocked level.
static var _last_level: int


## Initialize the save data.
static func _static_init() -> void:
	
	var path: StringName = &"user:/save.json"
	var file: FileAccess
	var json: JSON = JSON.new()
	
	if not FileAccess.file_exists(path):
		GameData._last_level = 1
		return
	file = FileAccess.open(path, FileAccess.READ)
	json.parse(file.get_as_text())
	file.close()
	GameData._last_level = json.get_data()
