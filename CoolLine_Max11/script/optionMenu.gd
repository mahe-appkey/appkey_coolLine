extends Node

const save_load_class = preload("res://CoolLine_Max11/script/save_load_data.gd")
var save_load = save_load_class.new()
onready var music_toggle = get_node("optionMenu_panel/optionDetailPanel/music_check")
onready var sfx_toggle = get_node("optionMenu_panel/optionDetailPanel/sfx_check")
onready var back_button = get_node("optionMenu_panel/backButton")
var config_arr = Array()
var bgm_cfg = ["bgm",1]
var sfx_cfg = ["sfx",1]

func _exit_tree():
	save_load.free()
	pass

func _ready():
	get_tree().set_auto_accept_quit(false)
	back_button.connect("button_up",self,"on_back_press")
	music_toggle.connect("pressed",self,"test_toggle")
	sfx_toggle.connect("pressed",self,"test_toggle")
	save_load.load_config()
	config_arr = save_load.get_all_config()
	adjust_setting()
	pass

func adjust_setting():
	for arr in config_arr:
		if arr[0] == bgm_cfg[0]:
			bgm_cfg[1] = arr[1]
		if arr[0] == sfx_cfg[0]:
			sfx_cfg[1] = arr[1]
	music_toggle.pressed = bool(bgm_cfg[1])
	sfx_toggle.pressed = bool(sfx_cfg[1])
	pass

func _notification(what):
	if (what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST):
		queue_free()
		get_tree().change_scene("res://CoolLine_Max11/node/mainMenu.tscn")

func on_back_press():
	queue_free()
	get_tree().change_scene("res://CoolLine_Max11/node/mainMenu.tscn")
	pass
 
func test_toggle():
	var cfg_ar = Array()
	bgm_cfg[1] = int(music_toggle.is_pressed())
	sfx_cfg[1] = int(sfx_toggle.is_pressed())
	cfg_ar.append(bgm_cfg)
	cfg_ar.append(sfx_cfg)
	save_load.save_config(cfg_ar)
	pass
