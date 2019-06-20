extends Node

signal t_score_update
signal score_update
var total_score : int
var rounds_score = Array()
var shots_score = Array()
var total_shots_score : int
var tile_green : int
const rounds_limit = 10
const shots_limit = 1
var num_shots
var current_rounds
onready var round_trans = get_node("round_label_container/round_label")
onready var board_control = get_node("Panel_board/board")
onready var shots_display = get_node("Panel_score_round/shots_container/shots_label/shots_num_label")
onready var t_score_display = get_node("Panel_score_round/t_score_container/t_score_label/t_score_num_label")
func _init():
	tile_green=0
	num_shots = shots_limit
	current_rounds = 5
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
	yield(get_tree().create_timer(1.5),"timeout")
	update_round_transition()
	pass

func update_round_transition():
	var round_str = "ROUND "
	if current_rounds <9:
		round_str = round_str+"0"+str(current_rounds+1)
	else:
		round_str = round_str+str(current_rounds+1)
	
	round_trans.text = round_str
	round_trans.get_child(0).play("round_start")
	pass
	
func on_tile_greened():
	tile_green +=1
	total_score = tile_green*10
#	t_score_display.text = str(total_score)
	pass

func on_shots_used():
	num_shots -=1
	if (num_shots<=0):
		num_shots=0
		emit_signal("t_score_update",10)
		emit_signal("score_update",current_rounds,99)
	shots_display.text=str(num_shots)
	pass

func calculate_round_score(round_id,score):
	rounds_score[round_id] = score
	pass
