extends Node

func _ready():
	$MainScreen.file_selected.connect(load_aic_editor)

func load_aic_editor(data):
	print("LOADING AIC EDITOR")
	var editor = load("res://AICEditor/aic_editor.tscn")
	editor = editor.instantiate()
	add_child(editor)
	editor.recieve_data(data)

func load_main_screen():
	var screen = load("res://GUI/main_screen.tscn")
	screen = screen.instantiate()
	screen.file_selected.connect(load_aic_editor)
	add_child(screen)
	

