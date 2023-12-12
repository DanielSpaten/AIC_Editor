class_name CharacterContainer
extends TabContainer

@onready var grid_container1 = $"Economy|Cast Managment/GridContainer1"
@onready var grid_container2 = $Military/GridContainer2
@onready var grid_container3 = $Other/GridContainer3

@onready var containers = [grid_container1, grid_container2, grid_container3]

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
		
		if item in StaticData.cont1:
			containers[0].add_child(val_editor)
		elif item in StaticData.cont3:
			containers[2].add_child(val_editor)
		else:
			containers[1].add_child(val_editor)
		val_editor.recieve_data(item, personality[item], type_dict[item])
		editors.append(val_editor)
		
func unload_data():
	save()
	for editor in editors:
		editor.queue_free()
	editors.clear()
	var new_containers = []
	for i in range(len(containers)):
		var container = containers[i]
		container.queue_free()
		container = load("res://AICEditor/grid_container.tscn")
		container = container.instantiate()
		new_containers.append(container)
		get_child(i).add_child(container)
	containers = new_containers
	
func save():
	for editor in editors:
		editor.save_data(personality)
