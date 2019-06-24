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
	back_button.connect("button_up",self,"on_back_press")
	save_load.load_score()
	score_arr = save_load.get_all_score()
	update_score_display()
	pass

func _notification(what):
	if (what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST):
		queue_free()
		get_tree().change_scene("res://CoolLine_Max11/node/mainMenu.tscn")

func on_back_press():
	queue_free()
	get_tree().change_scene("res://CoolLine_Max11/node/mainMenu.tscn")
	pass
	
func update_score_display():
	for i in range(score_arr.size()):
		for j in range (4-(str(i+1).length())):
			score_text+=" "
		score_text+=str(i+1)+". "
		for k in range (7-(str(score_arr[i][0]).length())):
			score_text+=" "
		score_text+=str(score_arr[i][0])+" "
		for l in range(10-(str(score_arr[i][1]).length())):
			score_text+=" "
		score_text+=str(score_arr[i][1])+" "
		for m in range(8-(str(score_arr[i][2]).length())):
			score_text+=" "
		score_text+=str(score_arr[i][2])+"\n"
	score_detail.text=score_text
	pass
