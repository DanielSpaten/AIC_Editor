extends Node

@onready var main_menu = $UILayer/MainMenu

func _ready() -> void:
	main_menu.connect("start_game", start_game)
	Network.connect("connection_failed", connection_failed)

func start_game():
	rpc("load_level")

@rpc("call_local")
func load_level():
	main_menu.queue_free()
	#var level = load("res://src/temp_map_2.tscn")
	var level = load("res://src/isometric_temp_map.tscn")
	level = level.instantiate()
	
	add_child(level)

func connection_failed():
	pass
