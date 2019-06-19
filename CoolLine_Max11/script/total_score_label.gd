extends Control

var total_score :int
onready var masterGame = get_node("../../")
onready var t_score_text = get_child(0).get_child(0)

func _ready():
	print("total_score: ",masterGame.total_score)
	t_score_text.text = str(masterGame.total_score)
	pass # Replace with function body.

func _process(delta):
	
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
