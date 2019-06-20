extends Label

var tween_text
var update_score = false
onready var masterGame = get_node("../../")
var init_value
var fin_value

func _init():
	init_value = 0
	fin_value = 0
	pass

func _ready():
	tween_text = Tween.new()
	add_child(tween_text)
	masterGame.connect("t_score_update",self,"on_total_score_updated")
	pass

func on_total_score_updated(val):
	init_value = fin_value
	fin_value = val
	update_score = true
	pass
	
func _process(delta):
	if update_score:
		print("update_score")
		update_the_score(init_value,fin_value)
#		tween_text.interpolate_method(self,"_t_score_update",init_value,fin_value,3,\
#		Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		update_score = false
	pass

func update_the_score(i_val,fin_val):
	print("i_val: ",i_val)
	print("fin_val:",fin_val)
	tween_text.interpolate_method(self,"set_text",i_val,fin_val,3,\
	Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	yield(tween_text,"tween_completed")
#	update_score=false
	pass