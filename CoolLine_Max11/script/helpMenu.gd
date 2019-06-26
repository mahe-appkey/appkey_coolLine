extends Node2D

signal help_exit
onready var help_detail = get_node("helpPanel/help_detail")
onready var exit_button = get_node("helpPanel/exitButton")
var help_text

func _ready():
	help_detail.bbcode_enabled = true
	exit_button.connect("button_up",self,"on_exit_press")
	update_help_text()
	pass
	
func _notification(what):
	if (what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST):
		on_exit_press()

func on_exit_press():
	self.hide()
	emit_signal("help_exit")
	pass
	
func update_help_text():
	help_detail.append_bbcode("[center][b]How to Play[/b][/center]\n\n")
	help_text=\
	"[table=2]"+\
	"[cell]1.[/cell][cell]Pieces are divided into four sections, each representing a number between 0 and 3, the sections colored red are the trigger point.\n[/cell]"+\
	"[cell]2.[/cell][cell]When a piece moved to an empty space, chain linkage will start in the direction of trigger point.\n[/cell]"+\
	"[cell]3.[/cell][cell]Pieces that in the chain linkage direction will rotate counter-clockwise by the number displayed in the previous pieces.\n[/cell]"+\
	"[cell]4.[/cell][cell]If in the chain linkage direction, interlocking encounter empty space, perimeter or number of previous pieces are 0 (chain blockage), chain linkage direction will turn to the left.\n[/cell]"+\
	"[cell]5.[/cell][cell]Chain linkage will stop if the 11 pieces interlocked or chain linkage encounter two times of chain blockage in a row in the same square.\n[/cell]"+\
	"[cell]6.[/cell][cell]When interlocking happened, piece's square will be activated from brown to green. Each square could only activated once.\n[/cell]"+\
	"[cell]7.[/cell][cell]Game consist of 10 rounds, in each round, player have 4 chances/shots in order to activated as many square as possible.\n[/cell]"+\
	"[cell]8.[/cell][cell]In each round, all square will be deactivated, while pieces direction and location will be maintained. Round end if all the square activated or player used all 4 chances/shots.\n[/cell]"+\
	"[/table]"+\
	"\n\n[center][b]How to Score[/b][/center]\n\n"+\
	"[table=2]"+\
	"[cell]1.[/cell][cell]If all square activated, the rounds will end and calculation for the score begin. Bonus score given determined by the number of remaining shots when all square activated.\n[/cell]"+\
	"[cell][/cell][cell]a. 2 shots remaining, Bonus Score: 2000[/cell]"+\
	"[cell][/cell][cell]b. 1 shots remaining, Bonus Score: 1500[/cell]"+\
	"[cell][/cell][cell]c. 0 shots remaining, Bonus Score: 1000\n[/cell]"+\
	"[cell][/cell][cell][u]Score Calculation:[/u][/cell]"+\
	"[cell][/cell][cell]\tScore = (Fp x Fs) + Bonus[/cell]"+\
	"[cell][/cell][cell]Fp: number of pieces interlocked in final shot.[/cell]"+\
	"[cell][/cell][cell]Fs: number of activated square in final shot.\n[/cell]"+\
	"[cell]2.[/cell][cell]If rounds end while not all square activated, score calculation would be:[/cell]"+\
	"[cell][/cell][cell]\tScore = (As x 10)[/cell]"+\
	"[cell][/cell][cell]As: number of activated square in the current round[/cell]"+\
	"[/table]"
	help_detail.append_bbcode(help_text)
	pass
