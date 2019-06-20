extends Control

const calc_time = 2
onready var score_text = get_node("round_label/score_label")
var score_value
var final_value
var tween_text

func _ready():
	tween_text = Tween.new()
	score_text.add_child(tween_text)
	score_value = 0
	final_value = 0
	pass

func on_update_score(val):
	score_value = final_value
	final_value += deg2rad(val)
	update_the_score()
	pass
	
func update_the_score():
	tween_text.interpolate_property(self,"score_value",score_value,final_value,calc_time,\
	Tween.TRANS_LINEAR,Tween.EASE_IN)
	tween_text.start()
	yield(tween_text,"tween_completed")
	pass

func _process(delta):
	var round_val = rad2deg(score_value)
	score_text.text = str(int(round_val))
	pass
