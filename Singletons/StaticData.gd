extends Node

var type_dict: Dictionary
var save_path = ""
var _save: SaveData

func _enter_tree():
	_create_or_load_save()

func _ready():
	type_dict = load_json_file("res://ressources/type_dictionary.json")

func _create_or_load_save():
	if SaveData.save_exists():
		_save = SaveData.load_save() as SaveData
	else:
		_save = SaveData.new()
		
		_save.path = last_path.new()
		_save.path.path = ""
		
		_save.write_save()
	
	save_path = _save.path.path

func write_save(path):
	_save.path.path = path
	save_path = path
	_save.write_save()
	
var resource = [
	"None",
	"Wood",
	"Hop",
	"Stone",
	"Iron",
	"Pitch",
	"Wheat",
	"Beer",
	"Flour",
	"Bows",
	"Crossbows",
	"Spears",
	"Pikes",
	"Maces",
	"Swords",
	"LeatherArmors",
	"IronArmors"
]

var taxes_gui = [
	"Popularity +7",
	"Popularity +5",
	"Popularity +3",
	"Popularity +1",
	"Popularity -2",
	"Popularity -4",
	"Popularity -6",
	"Popularity -8",
	"Popularity -12",
	"Popularity -16",
	"Popularity -20",
	"Popularity -24",
]

var taxes_value = [
	"1",
	"2",
	"3",
	"4",
	"5",
	"6",
	"7",
	"8",
	"9",
	"10",
	"11",
	"12"
]

var units = [
	"None",
	"Tunneler",
	"EuropArcher",
	"Crossbowman",
	"Spearman",
	"Pikeman",
	"Maceman",
	"Swordsman",
	"Knight",
	"Ladderman",
	"Engineer",
	"Monk",
	"ArabArcher",
	"Slave",
	"Slinger",
	"Assassin",
	"HorseArcher",
	"ArabSwordsman",
	"FireThrower"
]
var digging_units = [
	"None",
	"EuropArcher",
	"Spearman",
	"Pikeman",
	"Maceman",
	"Engineer",
	"Slave"
]
var siege_engines = [
	"None",
	"Catapult",
	"Trebuchet",
	"Mangonel",
	"Tent",
	"SiegeTower",
	"BatteringRam",
	"Shield",
	"TowerBallista",
	"FireBallista"
]

var farm_buildings = [
	"None",
	"WheatFarm",
	"HopFarm",
	"AppleFarm",
	"DairyFarm"
]

var blacksmith_settings = [
	"Maces",
	"Swords",
	"Both"
]
var poleturner_settings = [
	"Spears",
	"Pikes",
	"Both"
]
var fletcher_settings = [
	"Bows",
	"Crossbows",
	"Both"
]

var targeting_types = [
	"Gold",
	"Balanced",
	"Closest",
	"Any",
	"Player"
]

func write_json_file(filePath: String, data: Dictionary) -> void:
	if FileAccess.file_exists(filePath):
		var dataFile = FileAccess.open(filePath, FileAccess.WRITE)
		var stringifiedData = JSON.stringify(data, "\t", false)
		
		dataFile.store_string(stringifiedData)
	else:
		create_warning("File doesnt exist (" + filePath + ")")
		print("File doesnt exist (" + filePath + ")")


func load_json_file(filePath : String):
	if FileAccess.file_exists(filePath):
		
		var dataFile = FileAccess.open(filePath, FileAccess.READ)
		var parsedResult = JSON.parse_string(dataFile.get_as_text())
		if parsedResult is Dictionary:
			var dict = parsedResult
			for key in parsedResult.keys():
				dict[key] = parsedResult[key]
			return dict
		else:
			create_warning("Error reading file. File must be a '.json' file")
			print("Error reading file")
	
	else:
		create_warning("File doesnt exist (" + filePath + ")")
		print("File doesnt exist (" + filePath + ")")

func create_warning(dialog_text):
	var warning = AcceptDialog.new()
	warning.dialog_text = dialog_text
	warning.initial_position = Window.WINDOW_INITIAL_POSITION_CENTER_MAIN_WINDOW_SCREEN
	warning.title = "Warning"
	warning.show()
	get_tree().current_scene.add_child(warning)
