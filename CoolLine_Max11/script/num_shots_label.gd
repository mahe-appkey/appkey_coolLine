extends Control

onready var masterGame = get_node("../../")
onready var num_shots_text = get_child(0)

func _ready():
	num_shots_text.text = str(masterGame.num_shots)
	pass # Replace with function body.
