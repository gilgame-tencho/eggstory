extends Node

const STAND_UP: PackedScene = preload("res://Scenes/stand_up.tscn")
const MAIN_MENU: PackedScene = preload("res://Scenes/main_menu.tscn")
const ROOM: PackedScene = preload("res://Scenes/room.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func load_stand_up():
	get_tree().change_scene_to_packed(STAND_UP)

func load_main_menu():
	get_tree().change_scene_to_packed(MAIN_MENU)

func load_room():
	get_tree().change_scene_to_packed(ROOM)
