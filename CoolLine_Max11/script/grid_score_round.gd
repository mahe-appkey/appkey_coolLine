extends GridContainer

var num_column = 5
var num_slot = 10
var score_l_arr = Array()
onready var masterGame = get_node("../../")

func _init():
	self.set_columns(num_column)
	pass
	
func _ready():
	masterGame.connect("score_update",self,"score_update")
	for i in range(num_slot):
		var score = preload("res://CoolLine_Max11/node/score_label.tscn").instance()
		score.get_child(0).text = str(i+1)+"R"
		score_l_arr.append(score)
		
	for score in score_l_arr:
		add_child(score)
		
	for i in range(score_l_arr.size()):
		score_l_arr[i].get_child(0).get_child(0).text = str(masterGame.rounds_score[i])
	
	pass

func score_update(idx,val):
	score_l_arr[idx].on_update_score(val)
	pass