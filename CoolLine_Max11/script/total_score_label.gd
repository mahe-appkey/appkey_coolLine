extends Control

const calc_time = 1
var total_score
onready var masterGame = get_node("../../")
onready var t_score_text = get_node("t_score_label/t_score_num_label")
var score_value
var final_value
var tween_text

func _ready():
	tween_text = Tween.new()
	t_score_text.add_child(tween_text)
	score_value = 0
	final_value = 0
	masterGame.connect("t_score_update",self,"on_total_score_updated")
	t_score_text.set_text(str(masterGame.total_score))
	pass

func on_total_score_updated(val):
	score_value = final_value
	final_value = deg2rad(val)
	update_the_score()
	pass
	
func update_the_score():
	print("dor",rad2deg(final_value))
	tween_text.interpolate_property(self,"score_value",score_value,final_value,calc_time,\
	Tween.TRANS_LINEAR,Tween.EASE_IN)
	tween_text.start()
	yield(tween_text,"tween_completed")
	score_value = final_value
	pass

func _physics_process(delta):
	var round_val = rad2deg(score_value)
	t_score_text.text = str(round(round_val))
	pass
