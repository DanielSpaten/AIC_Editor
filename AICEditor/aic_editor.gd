extends Control

@onready var tab_container = $CenterContainer/ScrollContainer/TabContainer
@onready var character_container = preload("res://AICEditor/character_container.tscn")
@onready var save_label = $HBoxContainer/SaveLabel
var characters: Array
var character_scenes = []
var current_character_tab = -1
var save_label_text = ""

var first_load = true

func _input(event):
	if event.is_action_pressed("s"):
		if Input.is_action_pressed("ctrl"):
			_on_save_button_pressed()

func recieve_data(data):
	characters = data['AICharacters']
	
	for character_data in characters:
		var char_scene = character_container.instantiate()
		character_scenes.append(char_scene)

		tab_container.add_child(char_scene)
		
		char_scene.recieve_data(character_data)
	_on_tab_container_tab_changed(0)
	save_label_text = "File: " + StaticData.save_path.split("/")[-1] + "\n "
	save_label.text = save_label_text

func _on_tab_container_tab_changed(tab):
	if first_load:
		first_load = false
		return
	if !current_character_tab == -1:
		character_scenes[current_character_tab].unload_data()
	character_scenes[tab].load_data()
	current_character_tab = tab
	save_label.text = save_label_text


func _on_save_button_pressed():
	var ai_characters = []
	character_scenes[current_character_tab].save()
	for character in character_scenes:
		ai_characters.append(character.get_character_dict())
	StaticData.write_json_file(StaticData.save_path, {"AICharacters": ai_characters})
	save_label.text = save_label_text + "Changes have been saved!"


func _on_exit_button_pressed():
	get_parent().load_main_screen()
	queue_free()
