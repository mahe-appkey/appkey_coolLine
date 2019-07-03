extends Node2D

signal ok_press
signal exit_press
signal play_press
var score_detail_text
var cur_round
var round_all
var round_end_tex = preload("res://CoolLine_Max11/img/round_end.png")
var round_clear_tex = preload("res://CoolLine_Max11/img/round_end2.png")
onready var round_end = get_node("round_end")
onready var ok_button=get_node("round_end/ok_button")
onready var play_button=get_node("round_end/play_button")
onready var exit_button=get_node("round_end/exit_button")
onready var num_tile_clear=get_node("round_end/num_tile_clear")
onready var round_score=get_node("round_end/round_score")
onready var round_score2=get_node("round_end/round_score2")
onready var bonus_score = get_node("round_end/bonus_score")
onready var num_disk = get_node("round_end/num_disk")
onready var num_kuadrat = get_node("round_end/num_disk/num_disk2")
onready var pop_anim = get_node("pop_anim")
onready var light_anim = get_node("light_anim")
onready var light_01 = get_node("light_ray")
onready var light_02 = get_node("light_ray2")
onready var g_manager= get_node("../")
var tween_panel

func _init():
	pass
	
func _ready():
	round_all = g_manager.rounds_limit-1
	self.hide()
	light_01.hide()
	light_02.hide()
	play_button.hide()
	exit_button.hide()
	ok_button.hide()
	g_manager.connect("before_round_end",self,"on_round_end")
	g_manager.connect("game_end",self,"on_game_end")
	ok_button.connect("button_up",self,"on_ok_pressed")
	exit_button.connect("button_up",self,"on_exit_pressed")
	play_button.connect("button_up",self,"on_play_pressed")
	tween_panel = Tween.new()
	add_child(tween_panel)
	pass # Replace with function body.

func tween_pop_in():
	tween_panel.interpolate_property(round_end,'modulate',Color(1,1,1,0.5),Color(1,1,1,1),0.4,Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween_panel.start()
	tween_panel.interpolate_property(round_end,'rect_scale',Vector2(0.1,0.1),Vector2(1,1),1,Tween.TRANS_BACK, Tween.EASE_OUT)
	tween_panel.start()
	pass
	
func tween_pop_out():
	tween_panel.interpolate_property(round_end,'rect_scale',Vector2(1,1),Vector2(0.1,0.1),0.5,Tween.TRANS_BACK, Tween.EASE_IN)
	tween_panel.start()
	tween_panel.interpolate_property(round_end,'modulate',Color(1,1,1,1),Color(1,1,1,0.5),0.5,Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween_panel.start()
	pass
	
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
#	if cur_round <round_all:
#		score_detail_text =\
#		"ROUND 0"+str(cur_round+1)+"\n\n" 
#	else:
#		score_detail_text=\
#		"FINAL ROUND\n\n"

	if g_manager.is_complete:
		round_end.set_texture(round_clear_tex)
		num_disk.show()
		num_kuadrat.show()
		bonus_score.show()
		bonus_score.text = "+"+str(g_manager.bonus_complete[g_manager.num_shots])
		num_disk.text = str(g_manager.disk_spin_count)
		num_tile_clear.text = str(g_manager.tile_green_shots)
		round_score.text = str(g_manager.tile_green_shots*g_manager.disk_spin_count*g_manager.disk_spin_count)
		round_score2.text = "score: "+"+"+str(g_manager.rounds_score[cur_round])
#		score_detail_text +=\
#		"Spinning Drive:\n"+str(g_manager.disk_spin_count)+"\n\n"+\
#		"Green Square:\n"+str(g_manager.tile_green_shots)+"\n\n"+\
#		"Complete Bonus:\n"+str(g_manager.bonus_complete[g_manager.num_shots])+"\n\n"+\
#		"SCORE:\n+"+str(g_manager.rounds_score[cur_round])
#		"SCORE:\n("+\
#		str(g_manager.disk_spin_count)+" x "+\
#		str(g_manager.tile_green_shots)+") + "+\
#		str(g_manager.bonus_complete[g_manager.num_shots])+" = +"+\
#		str(g_manager.rounds_score[cur_round])
	else:
		round_end.set_texture(round_end_tex)
		num_disk.hide()
		num_kuadrat.hide()
		bonus_score.hide()
		num_tile_clear.text = str(g_manager.tile_green)
		round_score.text = str(g_manager.tile_green*10)
		round_score2.text = "score: "+"+"+str(g_manager.rounds_score[cur_round])
#		score_detail_text +=\
#		"Total Green Square:\n"+str(g_manager.tile_green)+"\n\n"+\
#		"Green Point:\n10\n\nComplete Bonus:\n0\n\n"+\
#		"SCORE:\n+"+str(g_manager.rounds_score[cur_round])
#		"SCORE:\n"+\
#		str(g_manager.tile_green)+" x 10 = +"+\
#		str(g_manager.rounds_score[cur_round])
	if cur_round==round_all:
		round_score2.text ="total score: "+\
		str(g_manager.total_score)
		
#	score_detail.text=score_detail_text

func toogle_popup():
	pop_anim.play("pop_panel_anim")
#	pop_anim.play("pop_score_anim")
	tween_pop_in()
	if g_manager.is_complete:
		light_01.show()
		light_02.show()
		light_anim.play("light_anim")
	if cur_round==round_all:
		ok_button.hide()
		play_button.show()
		exit_button.show()
	else:
		ok_button.show()
	pass
	
func on_ok_pressed():
#	print("ok press")
#	pop_anim.play_backwards("pop_score_anim")
#	yield(pop_anim,"animation_finished")
	tween_pop_out()
#	yield(tween_panel,"tween_completed")
	pop_anim.play_backwards("pop_panel_anim")
	light_01.hide()
	light_02.hide()
	light_anim.stop()
	yield(pop_anim,"animation_finished")
	self.hide()
	emit_signal("ok_press")
	pass
	
func _notification(what):
	if (what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST):
		if cur_round<round_all:
			on_ok_pressed()
		
func on_exit_pressed():
	light_01.hide()
	light_02.hide()
	light_anim.stop()
	emit_signal("exit_press")
	pass

func on_play_pressed():
	light_01.hide()
	light_02.hide()
	light_anim.stop()
	emit_signal("play_press")
	pass
