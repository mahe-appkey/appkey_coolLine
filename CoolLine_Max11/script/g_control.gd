extends Node

signal t_score_update
signal score_update
signal round_end
signal before_round_end
signal game_end

const save_load_class = preload("res://CoolLine_Max11/script/save_load_data.gd")
var save_load = save_load_class.new()
var cur_high_score
var total_score : int
var rounds_score = Array()
var shots_score = Array()
var total_shots_score : int
var tile_green : int
var tile_green_shots : int
var disk_spin_count : int
var bonus_complete = [1000,1500,2000]
var is_complete = false
const rounds_limit = 10
const shots_limit = 4
var num_shots
var current_rounds
#var score_data
onready var score_labels = get_node("Panel_score_round/grid_score_round")
onready var popup_control = get_node("popup_control")
onready var round_trans = get_node("round_label_container/round_label")
onready var board_control = get_node("Panel_board/board")
onready var shots_display = get_node("Panel_score_round/shots_container/shots_label/shots_num_label")
#onready var t_score_display = get_node("Panel_score_round/t_score_container/t_score_label/t_score_num_label")
onready var t_score_container = get_node("Panel_score_round/t_score_container")
var is_popup_show = false

func _init():
	tile_green=0
	tile_green_shots = 0
	disk_spin_count = 0
	num_shots = shots_limit
	current_rounds = -1
	total_score = 0
	total_shots_score = 0
	for i in range (rounds_limit):
		rounds_score.append(0)
	for i in range (shots_limit):
		shots_score.append(0)
	pass

func _exit_tree():
	save_load.free()
	queue_free()
	pass

func _notification(what):
	if (what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST) and not is_popup_show:
		on_exit_press()

func _ready():
	is_popup_show = false
	get_tree().set_auto_accept_quit(false)
	get_tree().set_quit_on_go_back(false)
	if save_load.load_score():
		cur_high_score = save_load.arr_score[0]
	else:
		cur_high_score = 0
	save_load.delete_save_score()
	board_control.connect("shots_used",self,"on_shots_used")
	board_control.connect("tile_greened",self,"on_tile_greened")
	board_control.connect("chain_end",self,"on_chain_end")
	board_control.connect("disk_spin",self,"on_disk_spin")
	self.connect("round_end",self,"on_round_end")
	popup_control.connect("play_press",self,"on_play_press")
	popup_control.connect("exit_press",self,"on_exit_press")
	no_input_me(false)
	on_round_start()
	pass

func update_round_transition():
	yield(get_tree().create_timer(1),"timeout")
	var round_str = "ROUND "
	if current_rounds <9:
		round_str = round_str+"0"+str(current_rounds+1)
	else:
		round_str = "FINAL ROUND"
	
	round_trans.text = round_str
	round_trans.get_node("round_label_anim").play_backwards("round_start")
	yield(round_trans.get_node("round_label_anim"),"animation_finished")
	no_input_me(true)
	pass
	
func on_disk_spin():
	disk_spin_count +=1
	pass
	
func on_round_end():
	if current_rounds <9:
		yield(t_score_container,"calc_done")
		on_round_start()
	else:
		yield(t_score_container,"calc_done")
		total_score = total_all_score()
		save_load.proc_cur_score(total_score)
		emit_signal("game_end")
		
	pass

func on_exit_press():
	get_tree().change_scene("res://CoolLine_Max11/node/mainMenu.tscn")
	pass

func on_play_press():
	get_tree().reload_current_scene()
	pass
	
func on_round_start():
	is_complete = false
	disk_spin_count = 0
	tile_green = 0
	tile_green_shots = 0
	current_rounds +=1
	num_shots = shots_limit
	shots_display.text=str(num_shots)
	board_control.reset_all_tile()
	score_labels.current_round_score(current_rounds)
	update_round_transition()
	pass
	
func no_input_me(able_input):
	board_control.able_to_drag = able_input
	pass
	
func on_tile_greened():
	tile_green_shots +=1
	pass
	
func on_chain_end():
	if (tile_green+tile_green_shots)<16:
		tile_green += tile_green_shots
		rounds_score[current_rounds] = tile_green*10
	else:
		is_complete = true
		rounds_score[current_rounds]+=disk_spin_count*tile_green_shots+bonus_complete[num_shots]
	if (num_shots<1) or is_complete:
		no_input_me(false)
		if current_rounds<9:
			emit_signal("before_round_end")
			is_popup_show = true
			yield(popup_control,"ok_press")
			is_popup_show = false
			emit_signal("score_update",current_rounds,rounds_score[current_rounds])
			emit_signal("t_score_update",total_all_score())
		else:
			emit_signal("score_update",current_rounds,rounds_score[current_rounds])
			emit_signal("t_score_update",total_all_score())
		emit_signal("round_end")
	else:
		emit_signal("score_update",current_rounds,rounds_score[current_rounds])
	tile_green_shots = 0
	disk_spin_count = 0
	pass
	
func on_shots_used():
	num_shots -=1
	if num_shots>0:
		shots_display.text=str(num_shots)
	if (num_shots<1):
		num_shots=0
		shots_display.text="X"
	pass

func total_all_score():
	var score_all = 0
	for i in range (rounds_limit):
		score_all += rounds_score[i]
	return score_all
	pass
