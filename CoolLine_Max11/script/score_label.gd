extends Control

const calc_time = 1
onready var score_text = get_node("round_label/score_label")
var score_value
var final_value
var tween_text_score

func _ready():
	tween_text_score = Tween.new()
	score_text.add_child(tween_text_score)
	score_value = 0
	final_value = 0
	not_active_score()
	pass

func normal_score():
	self.get_child(0).add_color_override("font_color", Color(1,1,1,0.5))
	self.get_child(0).get_child(0).add_color_override("font_color", Color(0,0,0,255))
	self.get_child(0).get_child(0).set_modulate(Color(0.7,0.7,0.7,1))
#	self.get_child(0).set("custom_colors/font_color",Color(255,255,255))
#	self.get_child(0).get_child(0).set("custom_colors/font_color",Color(0,0,0))
#	self.get_child(0).get_child(0).set("custom_styles/bg_color",Color(136,134,134))
	pass

func active_score():
	self.get_child(0).add_color_override("font_color", Color((255/255),(179/255),(179/255),1))
	self.get_child(0).get_child(0).add_color_override("font_color", Color(0,0,0,1))
	self.get_child(0).get_child(0).set_modulate(Color(1,1,1,1))
#	self.get_child(0).set("custom_colors/font_color",Color(255,179,179))
#	self.get_child(0).get_child(0).set("custom_colors/font_color",Color(0,0,0))
#	self.get_child(0).get_child(0).set("custom_styles/bg_color",Color(255,255,255))
	pass

func not_active_score():
	self.get_child(0).add_color_override("font_color", Color((134/255),(134/255),(134/255),0.5))
	self.get_child(0).get_child(0).add_color_override("font_color", Color((134/255),(134/255),(134/255),0.5))
	self.get_child(0).get_child(0).set_modulate(Color(1,1,1,0.5))
	pass


func on_update_score(val):
	score_value = final_value
	final_value = deg2rad(val)
	update_the_score()
	pass
	
func update_the_score():
	tween_text_score.interpolate_property(self,"score_value",score_value,final_value,calc_time,\
	Tween.TRANS_LINEAR,Tween.EASE_IN)
	tween_text_score.start()
	yield(tween_text_score,"tween_completed")
	score_value = final_value
	pass

func _physics_process(delta):
	var round_val = rad2deg(score_value)
	score_text.text = str(round(round_val))
	pass
