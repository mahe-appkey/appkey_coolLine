extends GridContainer

var num_row = 2.0
var num_column = 5
var num_slot
var score_l_arr = Array()
onready var masterGame = get_node("../../")

func _init():
	pass
	
func _ready():
#	if (masterGame.rounds_limit<=5):
#		num_row = 1.0
#	num_column = ceil(masterGame.rounds_limit/num_row)
#	print("col: ",num_column)
	self.set_columns(num_column)
	num_slot = masterGame.rounds_limit
	masterGame.connect("score_update",self,"score_update")
	for i in range(num_slot):
		var score = preload("res://CoolLine_Max11/node/score_label.tscn").instance()
		score.get_node("round_label").text = str(i+1)+"R"
		score_l_arr.append(score)
		
	for score2 in score_l_arr:
		add_child(score2)
		
	for i in range(score_l_arr.size()):
		score_l_arr[i].get_child(1).get_child(0).text = str(masterGame.rounds_score[i])
	
	pass
	
func current_round_score(idx):
	score_l_arr[idx].active_score()
	if idx>0:
		score_l_arr[idx-1].normal_score()
	pass
	
func score_update(idx,val):
	score_l_arr[idx].on_update_score(val)
	pass