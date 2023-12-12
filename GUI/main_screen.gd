class_name MainScreen
extends Control

@onready var file_selection = $FileSelection
@onready var file_dialog = $FileDialog

@onready var load_button = $CenterContainer/VBoxContainer/Load_AIC
@onready var exit_button = $CenterContainer/VBoxContainer/Exit

@onready var last_file_label = $CenterContainer/VBoxContainer/LastFileLabel
@onready var load_last_aic = $CenterContainer/VBoxContainer/LoadLastAIC

signal file_selected

func _ready() -> void:
	var file = FileAccess.open("res://ressources/last_aic.txt", FileAccess.READ)
	var content = file.get_as_text()
	if content == "":
		last_file_label.hide()
		load_last_aic.hide()
	else:
		last_file_label.text += content
		StaticData.save_path = content.replace("\n", "")

func _on_load_aic_pressed() -> void:
	if !file_selection.visible:
		file_selection.show()


func _on_create_aic_pressed() -> void:
	if !file_dialog.visible:
		file_dialog.show()


func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_file_dialog_confirmed(path) -> void:
	var data = StaticData.load_json_file("res://ressources/vanilla.json")
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_var(data)
	


func _on_file_selection_file_selected(path) -> void:
	file_selection.hide()
	if !(path.ends_with(".json") or path.ends_with(".JSON")):
		StaticData.create_warning("Selected file is not a '.json'-file")
		return
	var data = StaticData.load_json_file(path)
	StaticData.save_path = path
	var file = FileAccess.open("res://ressources/last_aic.txt", FileAccess.WRITE)
	file.store_line(path)
	emit_signal("file_selected", data)
	queue_free()
	


func _on_instructions_pressed() -> void:
	var info = AcceptDialog.new()
	info.title = "Instructions"
	info.dialog_text = "1. Load your .json-file with the 'Load AIC'-Button.\n 
						2. Edit the AIC-values as you like.\n 
						3. Press save and use the UCP to install the AIC"
	info.initial_position = Window.WINDOW_INITIAL_POSITION_CENTER_MAIN_WINDOW_SCREEN
	info.show()
	add_child(info)


func _on_load_last_aic_pressed():
	print(StaticData.save_path)
	_on_file_selection_file_selected(StaticData.save_path)
