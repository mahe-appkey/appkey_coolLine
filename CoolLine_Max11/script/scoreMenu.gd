extends Node

const save_load_class = preload("res://CoolLine_Max11/script/save_load_data.gd")
var save_load = save_load_class.new()
onready var score_detail = get_node("scoreMenu_panel/scoreDetailPanel/scoreDetail")
onready var back_button = get_node("scoreMenu_panel/backButton")
var score_text = ""
var score_arr = Array()

func _exit_tree():
	save_load.free()
	pass

func _ready():
	get_tree().set_auto_accept_quit(false)
	get_tree().set_quit_on_go_back(false)
	score_detail.bbcode_enabled=true
	back_button.connect("button_up",self,"on_back_press")
	save_load.load_score()
	score_arr = save_load.get_all_score()
	update_score_display()
	pass

func _notification(what):
	if (what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST):
		on_back_press()

func on_back_press():
	queue_free()
	get_tree().change_scene("res://CoolLine_Max11/node/mainMenu.tscn")
	pass
	
func update_score_display():
	if score_arr.size() < 1:
		score_text +=\
		"[center]\n\n\n\nNo Score Found[/center]"
	else:
		score_text+=\
		"[table=4]"
		for i in range(score_arr.size()):
			score_text+=\
			"[cell][right]"+str(i+1)+".[/right][/cell]"+\
			"[cell][right] "+str(score_arr[i][0])+"[/right][/cell]"+\
			"[cell][right] "+str(score_arr[i][1])+"[/right][/cell]"+\
			"[cell][right] "+str(score_arr[i][2])+"[/right][/cell]"
		score_text+=\
		"[/table]"
	score_detail.append_bbcode(score_text)
	pass
