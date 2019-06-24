extends Node

onready var start_button = get_node("mainMenu_panel/startButton")
onready var score_button = get_node("mainMenu_panel/scoreButton")
onready var option_button = get_node("mainMenu_panel/optionButton")
onready var help_button = get_node("mainMenu_panel/help_texButton")

func _ready():
	get_tree().set_auto_accept_quit(true)
	start_button.connect("button_up",self,"on_start_press")
	score_button.connect("button_up",self,"on_score_press")
	option_button.connect("button_up",self,"on_option_press")
	help_button.connect("button_up",self,"on_help_press")
	pass
	
func on_start_press():
	get_tree().change_scene("res://CoolLine_Max11/node/main.tscn")
	pass
	
func on_score_press():
	get_tree().change_scene("res://CoolLine_Max11/node/scoreMenu.tscn")
	pass
	
func on_option_press():
	get_tree().change_scene("res://CoolLine_Max11/node/optionMenu.tscn")
	pass
	
func on_help_press():
	pass
	
func _exit_tree():
	queue_free()
	pass
