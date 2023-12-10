class_name CharacterContainer
extends ScrollContainer

@onready var grid_container = $GridContainer

var value_editor = preload("res://AICEditor/value_editor.tscn")
var name_editor

var custom_name: String
var personality: Dictionary
var type_dict = StaticData.type_dict
var editors: Array[ValueEditor] = []

func get_character_dict():
	return { "Name": name, "CustomName": custom_name, "Personality": personality }

func recieve_data(data: Dictionary) -> void:
	name = data['Name']
	custom_name = data['CustomName']
	personality = data['Personality']
	
func load_data():
	print("Loading ", name, " Personality")
	for item in type_dict:
		var val_editor = value_editor.instantiate()
		var value = type_dict[item]
		
		var sizes = [40, 40, 57, 77, 97, 117, 137, 157, 177]
		val_editor.custom_minimum_size.y = sizes[(len(value[1]) / 44)]
		
		grid_container.add_child(val_editor)
		val_editor.recieve_data(item, personality[item], type_dict[item])
		editors.append(val_editor)
		
func unload_data():
	save()
	for editor in editors:
		editor.queue_free()
	editors.clear()
	grid_container.queue_free()
	remove_child(grid_container)
	grid_container = load("res://AICEditor/grid_container.tscn")
	grid_container = grid_container.instantiate()
	add_child(grid_container)
	
func save():
	for editor in editors:
		editor.save_data(personality)
