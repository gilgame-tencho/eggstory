extends Control

@onready var background: ColorRect = $BackGround
@onready var label: Label = $BackGround/VBoxContainer/Label

@export var wait_next_flg = false

const MAX_CHARA = 70
const MAX_LINE = 4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("called hud")
	set_process_internal(Node2D.PROCESS_MODE_ALWAYS)
	#hide_hud()
	show_hud()
	var load_text = ScenarioManager.load()
	console_text_set(load_text)
	SignalManager.on_talk.connect(show_hud)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if wait_next_flg && Input.is_action_just_pressed("enter"):
		print("next")
		next()

func hide_hud():
	background.visible = false

func show_hud():
	#get_tree().paused = true
	background.visible = true


@export var console_text_counter = 0
@export var console_text = ""
@export var chara_count = 0
@export var line_count = 0
func console_text_set(text):
	console_text = text
	console_text_counter = 0
	chara_count = 0
	line_count = 0
	$ConsoleTimer.start()

func _on_console_timer_timeout() -> void:
	if console_text_counter > console_text.length() :
		$ConsoleTimer.stop()
		ScenarioManager.save()
	else:
		console_text_counter += 1
		chara_count += 1
		var next_chara = console_text.substr(console_text_counter-1,1)
		if (next_chara == "\n") :
			print("  rn")
			chara_count = 0
			line_count += 1
			
		if (chara_count > MAX_CHARA) :
			print("  MAX_CHARA")
			chara_count = 0
			line_count += 1
			next_chara = "\n"
			console_text_counter -= 1
			#get_node("BackGround/VBoxContainer/Label").text += "\n"
			
		if (line_count >= MAX_LINE) :
			print("  MAX_LINE   Next chara:"+console_text.substr(console_text_counter,1))
			$ConsoleTimer.stop()
			wait_next_flg = true
			get_node("BackGround/VBoxContainer/Label").text += "   ...>"
		else:
			get_node("BackGround/VBoxContainer/Label").text += next_chara
			#get_node("BackGround/VBoxContainer/Label").text = console_text.substr(0,console_text_counter)



func next():
	wait_next_flg = false
	line_count = 0
	get_node("BackGround/VBoxContainer/Label").text = ""
	$ConsoleTimer.start()
