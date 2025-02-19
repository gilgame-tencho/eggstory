extends Node

func load():
	var load_file = FileAccess.open("res://Scenario/scenario_B001.txt", FileAccess.READ)
	return load_file.get_as_text()

func save():
	var f = FileAccess.open("res://Save/save_01.txt", FileAccess.WRITE)
	f.store_string("test save")
	f.close()
