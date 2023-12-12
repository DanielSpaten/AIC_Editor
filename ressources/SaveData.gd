class_name SaveData
extends Resource

const SAVE_PATH = "user://save.tres"

@export var path: Resource

func write_save() -> void:
	ResourceSaver.save(self, SAVE_PATH)

static func save_exists() -> bool:
	return ResourceLoader.exists(SAVE_PATH)
	
static func load_save() -> Resource:
	if save_exists():
		return load(SAVE_PATH)
	return null
