extends Node

signal t_score_update
signal score_update
signal round_end
signal game_end

var total_score : int
var rounds_score = Array()
var shots_score = Array()
var total_shots_score : int
var tile_green : int
var tile_green_shots : int
var disk_spin_count : int
var bonus_complete = [2000,1500,1000]
var is_complete = false
const rounds_limit = 10
const shots_limit = 4
var num_shots
var current_rounds
onready var score_labels = get_node("Panel_score_round/grid_score_round")
onready var popup_score = get_node("popup_control/popup_score")
onready var round_trans = get_node("round_label_container/round_label")
onready var board_control = get_node("Panel_board/board")
onready var shots_display = get_node("Panel_score_round/shots_container/shots_label/shots_num_label")
onready var t_score_display = get_node("Panel_score_round/t_score_container/t_score_label/t_score_num_label")
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

func _ready():
	board_control.connect("shots_used",self,"on_shots_used")
	board_control.connect("tile_greened",self,"on_tile_greened")
	board_control.connect("chain_end",self,"on_chain_end")
	board_control.connect("disk_spin",self,"on_disk_spin")
	self.connect("round_end",self,"on_round_end")
	no_input_me(false)
	popup_score.hide()
	on_round_start()
	pass

func update_round_transition():
	yield(get_tree().create_timer(1),"timeout")
	var round_str = "ROUND "
	if current_rounds <9:
		round_str = round_str+"0"+str(current_rounds+1)
	else:
		round_str = "FINAL ROUND"
#		round_str = round_str+str(current_rounds+1)
	
	round_trans.text = round_str
	print("animation_start")
	round_trans.get_child(0).play_backwards("round_start")
	yield(round_trans.get_child(0),"animation_finished")
	print("animation_end")
	no_input_me(true)
	pass
	
func on_disk_spin():
	disk_spin_count +=1
	pass
	
func on_round_end():
	if current_rounds <9:
		yield(get_tree().create_timer(2),"timeout")
		popup_score.hide()
		on_round_start()
	else:
		print("game_end")
	pass
	
func on_round_start():
	score_labels.current_round_score(0)
	is_complete = false
	disk_spin_count = 0
	tile_green = 0
	tile_green_shots = 0
	current_rounds +=1
	num_shots = shots_limit
	shots_display.text=str(num_shots)
	board_control.reset_all_tile()
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
		if num_shots == 2:
			rounds_score[current_rounds]+=tile_green*disk_spin_count*tile_green_shots+bonus_complete[0]
		elif num_shots == 1:
			rounds_score[current_rounds]+=tile_green*disk_spin_count*tile_green_shots+bonus_complete[1]
		elif num_shots == 0:
			rounds_score[current_rounds]+=tile_green*disk_spin_count*tile_green_shots+bonus_complete[2]
	print("tile_green_shots: ",tile_green_shots)
	print("tile_green: ",tile_green)
	print("disk_spin_count: ",disk_spin_count)
	tile_green_shots = 0
	disk_spin_count = 0
	emit_signal("score_update",current_rounds,rounds_score[current_rounds])
	emit_signal("t_score_update",total_all_score())
	if (num_shots<1) or is_complete:
		no_input_me(false)
#		yield(get_tree().create_timer(1),"timeout")
#		popup_score.show()
#		popup_score.get_child(2).play("detail_anim")
#		yield(popup_score.get_child(2),"animation_finished")
		emit_signal("round_end")
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
#func calculate_round_score(round_id,score):
#	rounds_score[round_id] = score
#	pass
