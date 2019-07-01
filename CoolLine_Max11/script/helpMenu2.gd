extends Node

signal help_exit
onready var help_detail = get_node("helpPanel/help_detail")
onready var exit_button = get_node("helpPanel/exitButton")
onready var next_button = get_node("helpPanel/nextButton")
var help_text

func _ready():
	help_detail.bbcode_enabled = true
	exit_button.connect("button_up",self,"on_back_press")
	next_button.connect("button_up",self,"on_next_press")
	update_help_text()
	pass

func on_next_press():
	get_tree().change_scene("res://CoolLine_Max11/node/helpMenu.tscn")
	pass

func _notification(what):
	if (what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST):
		on_back_press()

func on_back_press():
	queue_free()
	get_tree().change_scene("res://CoolLine_Max11/node/mainMenu.tscn")
	pass
	
func update_help_text():
	help_text=\
	"[table=2]"+\
	"[cell]1.[/cell][cell]If all square activated, the rounds will end and calculation for the score begin. Bonus score given determined by the number of remaining shots when all square activated.\n[/cell]"+\
	"[cell][/cell][cell]a. 2 shots remaining, Bonus Score: 2000[/cell]"+\
	"[cell][/cell][cell]b. 1 shots remaining, Bonus Score: 1500[/cell]"+\
	"[cell][/cell][cell]c. 0 shots remaining, Bonus Score: 1000\n[/cell]"+\
	"[cell][/cell][cell][u]Score Calculation:[/u][/cell]"+\
	"[cell][/cell][cell]\t[color=#bdc2fc]Score = (Fp x Fs) + Bonus[/color][/cell]"+\
	"[cell][/cell][cell]Fp: number of pieces interlocked in final shot.[/cell]"+\
	"[cell][/cell][cell]Fs: number of activated square in final shot.\n[/cell]"+\
	"[cell]2.[/cell][cell]If rounds end while not all square activated, score calculation would be:[/cell]"+\
	"[cell][/cell][cell]\t[color=#bdc2fc]Score = (As x 10)[/color][/cell]"+\
	"[cell][/cell][cell]As: number of activated square in the current round[/cell]"+\
	"[/table]"
	help_detail.append_bbcode(help_text)
	pass
