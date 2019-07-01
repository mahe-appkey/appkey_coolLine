extends Node2D

signal ok_press
signal exit_press
signal play_press
var score_detail_text
var cur_round
var round_all
onready var ok_button=get_node("popup_score/ok_button")
onready var play_button=get_node("popup_score/play_button")
onready var exit_button=get_node("popup_score/exit_button")
onready var score_detail=get_node("popup_score/score_detail")
onready var score_anim=get_node("popup_score/score_detail_anim")

onready var g_manager= get_node("../")

func _init():
	pass
	
func _ready():
	round_all = g_manager.rounds_limit-1
	self.hide()
	play_button.hide()
	exit_button.hide()
	ok_button.hide()
	g_manager.connect("before_round_end",self,"on_round_end")
	g_manager.connect("game_end",self,"on_game_end")
	ok_button.connect("button_up",self,"on_ok_pressed")
	exit_button.connect("button_up",self,"on_exit_pressed")
	play_button.connect("button_up",self,"on_play_pressed")
	pass # Replace with function body.

func on_round_end():
	cur_round=g_manager.current_rounds
	if cur_round<(round_all):
		self.show()
		update_score_detail()
		toogle_popup()
	pass
	
func on_game_end():
	cur_round=g_manager.current_rounds
	self.show()
	update_score_detail()
	toogle_popup()
	pass
	
func update_score_detail():
	if cur_round <round_all:
		score_detail_text =\
		"ROUND 0"+str(cur_round+1)+"\n\n" 
	else:
		score_detail_text=\
		"FINAL ROUND\n\n"
	
	if g_manager.is_complete:
		score_detail_text +=\
		"Spinning Drive:\n"+str(g_manager.disk_spin_count)+"\n\n"+\
		"Green Square:\n"+str(g_manager.tile_green_shots)+"\n\n"+\
		"Complete Bonus:\n"+str(g_manager.bonus_complete[g_manager.num_shots])+"\n\n"+\
		"SCORE:\n+"+str(g_manager.rounds_score[cur_round])
#		"SCORE:\n("+\
#		str(g_manager.disk_spin_count)+" x "+\
#		str(g_manager.tile_green_shots)+") + "+\
#		str(g_manager.bonus_complete[g_manager.num_shots])+" = +"+\
#		str(g_manager.rounds_score[cur_round])
	else:
		score_detail_text +=\
		"Total Green Square:\n"+str(g_manager.tile_green)+"\n\n"+\
		"Green Point:\n10\n\nComplete Bonus:\n0\n\n"+\
		"SCORE:\n+"+str(g_manager.rounds_score[cur_round])
#		"SCORE:\n"+\
#		str(g_manager.tile_green)+" x 10 = +"+\
#		str(g_manager.rounds_score[cur_round])
	if cur_round==round_all:
		score_detail_text+="\n\nTOTAL SCORE: "+\
		str(g_manager.total_score)
		
	score_detail.text=score_detail_text
	pass

func toogle_popup():
	score_anim.play("popup_anim")
	yield(score_anim,"animation_finished")
	score_detail.percent_visible = 0
	score_detail.show()
	score_anim.play("detail_anim")
	yield(score_anim,"animation_finished")
	if cur_round==round_all:
		ok_button.hide()
		play_button.show()
		exit_button.show()
	else:
		ok_button.show()
	pass
	
func on_ok_pressed():
	ok_button.hide()
	score_detail.hide()
	score_anim.play_backwards("popup_anim")
	yield(score_anim,"animation_finished")
	self.hide()
	emit_signal("ok_press")
	pass
	
func _notification(what):
	if (what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST):
		if cur_round<round_all:
			on_ok_pressed()
		
func on_exit_pressed():
	emit_signal("exit_press")
	pass

func on_play_pressed():
	emit_signal("play_press")
	pass
