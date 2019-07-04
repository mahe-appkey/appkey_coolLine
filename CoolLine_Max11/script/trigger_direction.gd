extends Node2D

signal trigger_pressed
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var btn_up = get_node("up_btn")
onready var btn_left = get_node("left_btn")
onready var btn_down = get_node("down_btn")
onready var btn_right = get_node("right_btn")

# Called when the node enters the scene tree for the first time.
func _ready():
	btn_up.connect("button_up",self,"on_up_press")
	btn_left.connect("button_up",self,"on_left_press")
	btn_down.connect("button_up",self,"on_down_press")
	btn_right.connect("button_up",self,"on_right_press")
	pass # Replace with function body.

func on_up_press():
	emit_signal("trigger_pressed","up")
func on_left_press():
	emit_signal("trigger_pressed","left")
func on_down_press():
	emit_signal("trigger_pressed","down")
func on_right_press():
	emit_signal("trigger_pressed","right")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
