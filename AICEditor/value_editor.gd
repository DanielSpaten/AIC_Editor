class_name ValueEditor
extends Control

@onready var grid_container = $GridContainer
@onready var name_label = $GridContainer/Name
@onready var line_edit = $GridContainer/LineEdit
@onready var option_button = $GridContainer/OptionButton
@onready var description = $GridContainer/Description

var using_line_edit: bool
var taxes = false

func save_data(personality):
	if using_line_edit:
		personality[name_label.text] = int(line_edit.text)
	else:
		if taxes:
			personality[name_label.text] = option_button.selected + 1
		else:
			personality[name_label.text] = option_button.get_item_text(option_button.selected)
		
func recieve_data(val_name, value, data):
	name_label.text = val_name
	description.text = data[1]
	if data[0] in ["Int32", "Int100", "Popularity"]:
		using_line_edit = true
		grid_container.remove_child(option_button)
		line_edit.text = str(value)
	else:
		using_line_edit = false
		grid_container.remove_child(line_edit)
		set_options_button(data[0], value)

	
func set_options_button(value_type, value):
	var array
	if value_type == "Farm":
		array = StaticData.farm_buildings
	elif value_type == "Unit":
		array = StaticData.units
	elif value_type == "DiggingUnit":
		array = StaticData.digging_units
	elif value_type == "Taxes":
		taxes = true
		array = StaticData.taxes_value
	elif value_type == "Resource":
		array = StaticData.resource
	elif value_type == "SiegeEngine":
		array = StaticData.siege_engines
	elif value_type == "Targeting":
		array = StaticData.targeting_types
	elif value_type == "Blacksmith":
		array = StaticData.blacksmith_settings
	elif value_type == "Poleturner":
		array = StaticData.poleturner_settings
	elif value_type == "Fletcher":
		array = StaticData.fletcher_settings
	elif value_type == "Bool":
		array = ["True", "False"]
		
	var index
	for i in range(len(array)):
		var element = array[i]
		if element == str(value):
			index = i
		if value_type == "Taxes":
			option_button.add_item(StaticData.taxes_gui[i])
		else:
			option_button.add_item(element)
	option_button.select(index)
	return option_button
